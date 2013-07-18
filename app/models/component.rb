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

  has_many                      :product_components,    :dependent  => :destroy
  has_many                      :products,              :through    => :product_components

  # has_many                      :subcomponents, :dependent => :destroy
  # accepts_nested_attributes_for :subcomponents, reject_if: proc { |attrs| attrs['title'].blank? }, allow_destroy: true


  has_many                      :products
  has_many                      :complilations
  
  belongs_to                    :category
  belongs_to                    :product
  
  validates_presence_of         :category
  validates_presence_of         :title

  before_save                   :create_name


  def parent
    @pid = parent_id

    if @pid.blank? || @pid == 0
      @pid = id
    end

    @parent = Component.find(@pid)
    return @parent
  end

  def get_top_level(component = self)
    if component.parent_id && component.parent_id != 0
      component = get_top_level(Component.find(component.parent_id))
    end

    return component
  end

  def children
    @children = Component.all(:conditions => { :parent_id => id })
    return @children
  end

  def self.get_ordered
    ordered = Array.new
    @top_level_components = Component.where(:parent_id => nil)

    @top_level_components.each do |component|
      ordered.push(component)

      populate_array(component, ordered)
    end

    return ordered
  end

  private
  
  def create_name
    self.name = title.parameterize
  end

  def self.populate_array(element, array)
    element.children.each do |child|
      array.push(child)

      populate_array(child, array)
    end
  end
end
