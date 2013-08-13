class Category < ActiveRecord::Base
  default_scope order('categories.title ASC')

  # CATEGORY_KINDS = [["Product", 0],["Page", 1]]

  # scope :products, where(:kind => 0)
  # scope :pages, where(:kind => 1)
  
  attr_accessible       :name, 
                        :title, 

                        ##belongs_to##

                        ##has_many##
                        :component_ids



  has_many              :components

  validates_presence_of :title

  before_save           :create_name

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
  
  private

  def create_name
    self.name = title.parameterize
  end
end