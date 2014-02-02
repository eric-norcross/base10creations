class Sku < ActiveRecord::Base
  include PgSearch

  multisearchable against: [:title]

  default_scope order('skus.id ASC')

  attr_accessible               :name,
                                :title,

                                ## belongs_to ##
                                :product_id,
                                :finish_id,

                                ## has_many ##

                                ## nested attributes ##
                                :images_attributes

  belongs_to                    :product
  belongs_to                    :finish

  has_many                      :compilation_skus, dependent: :destroy
  has_many                      :compilations,     through: :compilation_skus

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  validates_presence_of         :images
  validates_presence_of         :title

  before_save                   :create_name

  def self.product(product_id = :product_id)
    return Product.find(product_id)
  end

  def list_image
    if images.length == 0 
      return Image.default.to_s
    else
      return images.first.asset.filename.to_s
    end
  end

  def related(product)
    collections = Collection.all
    collection = collections.select{|collection| collection.id == product.collection_id.to_f}.pop
    collection_patriarch = Family.patriarch(collections, collection)

    # Rails.logger.debug "DEBUG - collection_patriarch: #{collection_patriarch}"

    @products_and_compilations = Collection.products_and_compilations(collection_patriarch.id)
    # Rails.logger.debug "DEBUG - @products_and_compilations.inspect: #{@products_and_compilations.inspect}"
    # Rails.logger.debug "DEBUG - @products_and_compilations: #{@products_and_compilations}"


    # @products_and_compilations = Product.where(collection_id: product.collection_id) + Compilation.where(collection_id: product.collection_id)
    @categories = product.categories
    @related = []
    

    # Rails.logger.debug "DEBUG - @categories.inspect: #{@categories.inspect}"

    @products_and_compilations.each do |item|
      # Rails.logger.debug "DEBUG - item.categories.inspect: #{item.categories.inspect}"
      if item.categories(collection_patriarch.id).to_set.superset?(@categories.to_set)
        if item.is_a?(Product)
          @related.push(item)
        else
          if item.is_a?(Compilation) && item.finish_id == finish_id
            @related.push(item)
          end
        end
      end
    end



    return @related
  end

  def collection
    return product.collection 
  end

  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end

  private
  
    def create_name
      self.name = title.parameterize
    end

end
