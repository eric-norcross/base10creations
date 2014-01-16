class Component < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('components.title ASC')

  attr_accessible               :name, 
                                :title,
                                :parent_id,
                                :active,

                                ## belongs_to ##
                                :category_id,

                                ## has_many ##

                                ## nested attributes ##
                                :images_attributes


  has_many                      :product_components,    dependent: :destroy
  has_many                      :products,              through: :product_components

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  
  belongs_to                    :category
  
  validates_presence_of         :category
  validates_presence_of         :title
  validates_presence_of         :parent_id

  validate                      :cannot_assign_to_self

  before_save                   :create_name
  before_destroy                :reset_children 

  def cannot_assign_to_self
    errors.add :base, "You cannot add a Component as a parent of it's self." if self.parent_id == self.id
  end

  def categories
    @categories = []

    @categories.push(category) if category
    
    if parent_id > 0
      @categories.push(Component.find(parent_id).categories)
    end

    return @categories.flatten.uniq
  end

  def reset_children # Resets all child elements of a destroyed element back to 0 and inactivates them
    Component.where(parent_id: id).each do |child|
      child.update_attributes(:parent_id => 0, :active => false)
    end
  end

  def self.products_and_compilations(component_ids)
    # Get all Products based on the Components/Sub-Components [Optimize by selected product_id's only]
    @product_ids = ProductComponent.where(:component_id => component_ids).map{ |product_component| product_component.product_id }
    
    @products = Product.where(id: @product_ids)
    # @products = Product.where(id: @product_ids, shown: true)

    # Create an array of Skus where the Sku belongs to a Compilation
    # Also create an array of Products not to include if their skus belong to a Compilation
    @compilation_ids = []
    @compilations = []
    @products.each do |product|
      product.skus.each do |sku|
        sku.compilations.each do |compilation|
          @compilation_ids.push(compilation.id) unless @compilation_ids.include?(compilation.id)
        end
      end
    end

    # Get Compilations where the Product of the Sku had one of the Components assigned
    @compilations = Compilation.where(:id => @compilation_ids)

    # Return the combined Products and Compilations
    return (@products + @compilations).sort_by(&:name)
  end

  def path
    return component_path(id)
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
