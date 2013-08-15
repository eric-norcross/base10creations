class Component < ActiveRecord::Base
  default_scope order('components.title ASC')

  attr_accessible               :name, 
                                :title,
                                :parent_id,

                                ## belongs_to ##
                                :category_id,

                                ## has_many ##
                                :product_ids

                                ## nested attributes ##



  has_many                      :product_components,    :dependent  => :destroy
  has_many                      :products,              :through    => :product_components
  
  belongs_to                    :category
  
  validates_presence_of         :category
  validates_presence_of         :title

  validate                      :cannot_assign_to_self

  before_save                   :create_name

  def cannot_assign_to_self
    errors.add :base, "You cannot add a Component as a parent of it's self." if self.parent_id == self.id
  end

  def patriarch
    if parent_id == 0
      return self
    else 
      return parent.patriarch
    end
  end
  
  def parent
    if parent_id == 0
      return self
    else 
      return Component.find(parent_id)
    end
  end

  def children
    return Component.where(:parent_id => id)
  end

  def siblings
    if parent_id == 0
      return Component.where(:parent_id => parent_id)
    else
      return parent.children
    end
  end

  def categories
    @categories = [category]
    if parent_id > 0
      @categories.push(parent.categories)
    end

    return @categories.flatten.uniq
  end

  def self.products_and_compilations(component_ids)
    # Get all Products based on the Components/Sub-Components [Optimize by selected product_id's only]
    @product_ids = ProductComponent.where(:component_id => component_ids).map{ |product_component| product_component.product_id }
    @products = Product.where(:id => @product_ids)

    # Create an array of Skus where the Sku belongs to a Compilation
    # Also create an array of Products not to include if their skus belong to a Compilation
    @compilation_ids = []
    @products.each do |product|
      product.skus.each do |sku|
        if sku.compilation_id
          @compilation_ids.push(sku.compilation_id) unless @compilation_ids.include?(sku.compilation_id)
        end
      end
    end

    # Get Compilations where the Product of the Sku had one of the Components assigned
    @compilations = Compilation.where(:id => @compilation_ids)

    # Return the combined Products and Compilations
    return (@products + @compilations).sort_by(&:name)
  end

  private
  
  def create_name
    self.name = title.parameterize
  end
end
