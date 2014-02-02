class Category < ActiveRecord::Base
  require 'family'

  include Rails.application.routes.url_helpers

  default_scope order('categories.title ASC')
  
  attr_accessible               :name, 
                                :title, 
                                :link,

                                ##belongs_to##

                                ##has_many##
                                :component_ids,

                                ## nested attributes ##
                                :images_attributes



  has_many                      :components

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true


  validates_presence_of         :title
  validates                     :link, :format => /(^$)|(^(http:\/\/|https:\/\/|\/))/ix 

  before_save                   :create_name

  def products(collection_ids = nil)
    # Rails.logger.debug "DEBUG: component_ids: #{component_ids}"

    product_ids = ProductComponent.where(component_id: component_ids).map{|product_component| product_component.product_id}

    conditions = {}
    conditions[:id] = product_ids.uniq
    conditions[:collection_id] = collection_ids unless collection_ids.blank?

    thing = Product.find(:all, conditions: conditions)

    return thing
  end

  def compilations(collection_ids = nil)
    compilation_ids = []
    products.each do |product| 
      product.skus.each do |sku|
        compilation_ids.push(sku.compilation_ids)
      end
    end

    conditions = {}
    conditions[:id] = compilation_ids.uniq
    conditions[:collection_id] = collection_ids unless collection_ids.blank?

    return Compilation.find(:all, conditions: conditions)
  end

  def collections
    collections = []
    products.each do |product|
      push(product.collection)
    end

    return collections.uniq
  end

  def products_and_compilations(collection_id = nil)
    return products(collection_id) + compilations(collection_id)
  end

  def self.categories_by_collection(collection_id)
    # @product_ids_by_collection = Product.where(collection_id: collection_id).pluck(:id)
    # @component_ids = ProductComponent.where(product_id: @product_ids_by_collection).pluck(:component_id).uniq
    # @category_ids = Component.where(id: @component_ids).pluck(:category_id).uniq
    # return Category.find(@category_ids)

    collections = Collection.all
    collection = collections.select{|collection| collection.id == collection_id.to_f}.pop
    collection_ids = Family.lineage(collections, collection).map{|collection| collection.id}.uniq

    return Category.joins(:components => :products).where(:products => {:collection_id => collection_ids}).uniq
  end

  def also_available_in(collection_id, finish_id)
    finish_id = finish_id.to_i

    collections = Collection.all
    collection = collections.select{|collection| collection.id == collection_id.to_f}.pop
    collection_ids = Family.lineage(collections, collection).map{|collection| collection.id}.uniq

    product_skus = []
    products(collection_ids).each do |product|
      product.skus.each do |sku|
        product_skus.push(sku) if sku.finish_id == finish_id
      end
    end

    return product_skus + compilations(collection_ids).delete_if{|compilation| compilation.finish_id != finish_id}
  end

  def path
    if link && link != ""
      return link
    else
      return category_path(id)
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
end