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
  validates_presence_of         :description, :unless => proc { |attrs| attrs['parent_id'].present? && attrs['parent_id'] > 0 }
  validates                     :link, :format => /(^$)|(^(http:\/\/|https:\/\/|\/))/ix
  validates                     :brands, presence: true
  validates                     :styles, presence: true

  before_save                   :create_name

  before_destroy                :reset_children


  def self.finishes(collection_id)
    return Finish.where(id: finish_ids(collection_id))
  end

  def self.skus_by_finish(collection_id, finish_id)
    skus = []

    products(collection_ids(collection_id)).each do |product|
      product.skus.each do |sku|
        if sku.finish_id.to_s == finish_id.to_s
          skus.push(sku) unless skus.include?(sku)
        end
      end
    end

    return skus
  end

  def self.products_and_compilations(collection_id)
    ids = collection_ids(collection_id)
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


  private
  
    def create_name
      self.name = title.parameterize
    end

    def self.collection_ids(collection_id)
      collections = Collection.all
      collection = collections.select{|collection| collection.id == collection_id.to_f}.pop
      return Family.decendants(collections, collection).map{|collection| collection.id}.uniq
    end

    def self.products(ids)
      return Product.where(collection_id: ids)
    end

    def self.compilations(ids)
      return Compilation.where(collection_id: ids)
    end

    def self.finish_ids(collection_id)
      finish_ids = []
      products(collection_ids(collection_id)).each do |product|
        product.skus.each do |sku|
          finish_ids.push(sku.finish_id) unless finish_ids.include?(sku.finish_id)
        end
      end

      return finish_ids
    end
end
