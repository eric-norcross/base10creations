class Component < ActiveRecord::Base
  default_scope order('components.title ASC')

  attr_accessible               :name, 
                                :title,
                                :parent_id,

                                ## belongs_to ##
                                :category_id,
                                :product_id,

                                ## has_many ##
                                :collection_ids,
                                :product_ids

                                ## nested attributes ##
                                # :subcomponents_attributes


  has_many                      :collection_components, :dependent  => :destroy
  has_many                      :collections,           :through    => :collection_components

  has_many                      :product_compilation_components,    :dependent  => :destroy
  has_many                      :products,              :through    => :product_compilation_components

  # has_many                      :subcomponents, :dependent => :destroy
  # accepts_nested_attributes_for :subcomponents, reject_if: proc { |attrs| attrs['title'].blank? }, allow_destroy: true


  has_many                      :products
  has_many                      :complilations
  
  belongs_to                    :category
  belongs_to                    :product
  
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

  # def self.get_ordered
  #   ordered = Array.new
  #   @top_level_components = Component.where(:parent_id => nil)

  #   @top_level_components.each do |component|
  #     ordered.push(component)

  #     populate_array(component, ordered)
  #   end

  #   return ordered
  # end

  private
  
  def create_name
    self.name = title.parameterize
  end

  # def self.populate_array(element, array)
  #   element.children.each do |child|
  #     array.push(child)

  #     populate_array(child, array)
  #   end
  # end
end
