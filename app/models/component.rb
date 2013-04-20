class Component < ActiveRecord::Base
  default_scope order('components.id ASC')

  attr_accessible         :category_id, 
                          :name, 
                          :title,
                          :collection_ids,
                          :style_ids

  has_many                :collection_components, :dependent => :destroy
  has_many                :collections,           :through => :collection_components

  has_many                :component_styles
  has_many                :styles,                :through => :component_styles

  has_many                :brands,                :through => :styles
  
  belongs_to              :category
  
  validates_presence_of   :category
  validates_presence_of   :title

  before_save             :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
