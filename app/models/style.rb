class Style < ActiveRecord::Base
  default_scope order('styles.id ASC')

  attr_accessible         :name, 
                          :title,
                          :component,
                          :collection #:collection_id

  has_many                :component_styles, :dependent => :destroy
  has_many                :components, :through => :component_styles

  has_many                :collections

  #belongs_to              :collection
  
  #validates_presence_of   :component
  validates_presence_of   :title

  before_save             :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
