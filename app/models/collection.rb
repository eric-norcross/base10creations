class Collection < ActiveRecord::Base
  default_scope order('collections.title ASC')

  attr_accessible               :name, 
                                :title,
                                :description,
                                ##belongs_to##

                                ##has_many##
                                :component_ids,
                                :style_ids

  has_many                      :collection_components, :include => :component
  has_many                      :components,            :through => :collection_components
  accepts_nested_attributes_for :collection_components, :allow_destroy => true

  has_many                      :collection_styles,     :include => :style
  has_many                      :styles,                :through => :collection_styles
  accepts_nested_attributes_for :collection_styles,     :allow_destroy => true
  
  validates_presence_of         :title
  validates_presence_of         :component_ids
  # validates_presence_of         :style_ids

  before_save                   :create_name

  def products
    @products = Product.all(:collection_id => :id)
    return @products
  end

  private
  
  def create_name
    self.name = title.parameterize
  end
end
