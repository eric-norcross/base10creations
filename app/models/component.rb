class Component < ActiveRecord::Base
  default_scope order('components.title ASC')

  attr_accessible               :name, 
                                :title,

                                ## belongs_to ##
                                :category_id,

                                ## has_many ##
                                :collection_ids,
                                :product_ids,
                                # :style_ids

                                ## nested attributes ##
                                :subcomponents_attributes


  has_many                      :collection_components, :dependent => :destroy
  has_many                      :collections,           :through => :collection_components

  has_many                      :subcomponents, :dependent => :destroy
  accepts_nested_attributes_for :subcomponents, reject_if: proc { |attrs| attrs['title'].blank? }, allow_destroy: true


  has_many                      :products
  has_many                      :complilations

  # has_many                    :component_styles
  # has_many                    :styles,                :through => :component_styles

  # has_many                    :brands,                :through => :styles
  
  belongs_to                    :category
  
  validates_presence_of         :category
  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
