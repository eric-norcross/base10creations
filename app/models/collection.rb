class Collection < ActiveRecord::Base
  require 'family'

  include Rails.application.routes.url_helpers

  default_scope order('collections.name ASC')

  attr_accessible               :name, 
                                :title,
                                :description,
                                :link,
                                :parent_id,

                                ## belongs_to ##

                                ## has_many ##,
                                :style_ids,
                                :brand_ids,
                                :products,

                                ## nested attributes ##
                                :images_attributes


  has_many                      :collection_styles,     dependent: :destroy
  has_many                      :styles,                through: :collection_styles

  has_many                      :brand_collections,     dependent: :destroy
  has_many                      :brands,                through: :brand_collections

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  has_many                      :products
  
  validates_presence_of         :title
  validates                     :description, presence: true, unless: :check_for_parent_id
  validates                     :link, :format => /(^$)|(^(http:\/\/|https:\/\/|\/))/ix
  validates                     :brands, presence: true, unless: :check_for_parent_id
  validates                     :styles, presence: true, unless: :check_for_parent_id

  before_save                   :create_name

  before_destroy                :reset_children


  def self.finishes(collection_id)
    return Finish.where(id: finish_ids(collection_id))
  end

  def self.skus_by_finish(collection_id, finish_id)
    skus = []

    products(collection_ids(collection_id, Family::DESCENDANTS, true)).each do |product|
      product.skus.each do |sku|
        if sku.finish_id.to_s == finish_id.to_s
          skus.push(sku) unless skus.include?(sku)
        end
      end
    end

    return skus
  end

  def self.products_and_compilations(collection_id, relationship = Family::DESCENDANTS)
    ids = (collection_ids(collection_id, relationship).push(collection_id)).flatten.uniq
    return (products(ids) + compilations(ids)).sort_by(&:name)
  end

  def categories
    @products_and_compilations = self.class.products_and_compilations(id)
    @categories = []
    @products_and_compilations.each do |item|
      item.categories.each do |category| 
        @categories.push(category) unless @categories.include?(category)
      end
    end

    return @categories
  end

  def reset_children
    Collection.where(parent_id: id).each do |child|
      child.update_attributes(:parent_id => 0)
    end
  end

  def path
    if link && link != ""
      return link
    else
      return collection_path(id)
    end
  end

  def list_image
    if images.length > 0 
      return images.first.asset.filename.to_s
    else
      return Image.default.to_s
    end
  end

  def get_description
    Rails.logger.debug "DEBUG - get_description"
    if parent_id > 0 && description.blank?
      collections = Collection.all
      collection = collections.select{|collection| collection.id == id.to_f}.pop
      return Family.parent(collections, collection).description
    else
      return description
    end
  end

  def get_brands
    if parent_id > 0 && brands.blank?
      collections = Collection.all
      collection = collections.select{|collection| collection.id == id.to_f}.pop
      return Family.parent(collections, collection).brands
    else
      return brands
    end
  end

  def get_styles
    if parent_id > 0 && styles.blank?
      collections = Collection.all
      collection = collections.select{|collection| collection.id == id.to_f}.pop
      return Family.parent(collections, collection).styles
    else
      return styles
    end
  end

  def get_patriarch
    if parent_id > 0
      collections = Collection.all
      collection = collections.select{|collection| collection.id == id.to_f}.pop
      return Family.patriarch(collections, collection)
    else 
      return self
    end
  end

  def get_patriarch_title
    if parent_id > 0
      return get_patriarch.title
    else 
      return title
    end
  end

  private
    def check_for_parent_id
      return proc { |attrs| attrs['parent_id'].present? && attrs['parent_id'] > 0 }
    end
  
    def create_name
      self.name = title.parameterize
    end

    def self.collection_ids(collection_id, relationship = Family::DESCENDANTS, include_self = false)
      ids = []
      collections = Collection.all
      collection = collections.select{|collection| collection.id == collection_id.to_f}.pop

      case relationship
      when Family::PATRIARCH
        ids.push(Family.patriarch(collections, collection).id)
      when Family::PARENT
        ids.push(Family.parent(collections, collection).id)
      when Family::CHILDREN
        ids = Family.children(collections, collection).map{|collection| collection.id}.uniq
      when Family::DESCENDANTS
        ids = Family.descendants(collections, collection).map{|collection| collection.id}.uniq
      when Family::LINEAGE
        ids = Family.lineage(collections, collection).map{|collection| collection.id}.uniq
      when Family::SIBLINGS
        ids = Family.siblings(collections, collection).map{|collection| collection.id}.uniq
      end

      if include_self
        ids.push(collection_id)
      end

      return ids.flatten.uniq
    end

    def self.products(ids)
      return Product.where(collection_id: ids)
    end

    def self.compilations(ids)
      return Compilation.where(collection_id: ids)
    end

    def self.finish_ids(collection_id)
      finish_ids = []
      products(collection_ids(collection_id, Family::DESCENDANTS, true)).each do |product|
        product.skus.each do |sku|
          finish_ids.push(sku.finish_id) unless finish_ids.include?(sku.finish_id)
        end
      end

      return finish_ids
    end
end
