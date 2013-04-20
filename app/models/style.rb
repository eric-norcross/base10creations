class Style < ActiveRecord::Base
  default_scope order('styles.id ASC')

  attr_accessible               :brand_id,
                                :name, 
                                :title,
                                :component,
                                :collection_ids
                                #,:brand_ids

  has_many                      :component_styles,  :dependent => :destroy
  has_many                      :components,        :through => :component_styles

  # has_many                      :brand_styles,      :dependent => :destroy
  # has_many                      :brands,            :through => :brand_styles

  has_many                      :collection_styles, :include => :collection
  has_many                      :collections,       :through => :collection_styles
  accepts_nested_attributes_for :collection_styles, :allow_destroy => true

  belongs_to                    :brand
  
  #validates_presence_of        :component
  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
