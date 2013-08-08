class Compilation < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  attr_accessible 							:name, 
  															:title,
                                :active,
                                :include_finish_name,

  															# belongs_to ##
 																:skin_id,
                                :collection_id,
                                :finish_id,

                                ## has_many ##
																:sku_ids,

                                ## nested attributes ##
                                :images_attributes

  belongs_to                    :collection
  belongs_to                    :finish
  belongs_to                    :skin
    
  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

	has_many                      :skus

	validates_presence_of         :title
  validates_presence_of         :collection
  validates_presence_of         :skin

	before_save                   :create_name

  def show
    return :active
  end

  def path(sku = nil)
    if sku
      return compilation_product_sku_path(id, sku.product_id, sku.id)
    else
      return compilation_path(id)
    end
  end

  def products
    @products = Product.where(:id => skus.map{ |sku| sku.product_id })
    return @products
  end

  def list_image
    if images.length > 0 
      return images.first
    else
      if skus.length == 0
        return Image.default
      else 
        if skus.first.images.length > 1
          return skus.first.images.second
        else 
          return skus.first.images.first
        end
      end
    end
  end

	private

  def create_name
    self.name = title.parameterize
  end                             
end