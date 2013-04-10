class Collection < ActiveRecord::Base
  default_scope order('collections.id ASC')

  attr_accessible               :style_id, 
                                :name, 
                                :title,
                                :component_ids

  #has_one                       :style
  has_many                      :collection_components, :include => :component
  has_many                      :components,            :through => :collection_components
  accepts_nested_attributes_for :collection_components, :allow_destroy => true

  belongs_to                    :style
  
  #validates_presence_of         :style
  validates_presence_of         :title
  validates_presence_of         :component_ids

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
