class Category < ActiveRecord::Base
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

  before_save                   :create_name

  def products
    @product_ids = ProductComponent.where(component_id: component_ids).map{|product| product.id}
    return Product.where(id: @product_ids)
  end

  def compilations
    @compilation_ids = []
    products.each do |product| 
      product.skus.each do |sku|
        if (sku.compilation_id)
          @compilation_ids.push(sku.compilation_id) unless @compilation_ids.include?(sku.compilation_id)
        end
      end
    end

    return Compilation.where(id: @compilation_ids)
  end

  def products_and_compilations
    return products + compilations
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