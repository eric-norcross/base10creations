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
    @products_and_compilations = Product.where(collection_id: product.collection_id) + Compilation.where(collection_id: product.collection_id)
    @categories = product.categories
    @related = []
    
    @products_and_compilations.each do |item|
      if item.categories.to_set.superset?(@categories.to_set)
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

  private
  
  def create_name
    self.name = title.parameterize
  end

end
