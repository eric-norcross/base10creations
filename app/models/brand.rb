class Brand < ActiveRecord::Base
  default_scope order('brands.id ASC')

  attr_accessible               :name, 
                                :title,
                                :style_ids

  has_many                      :brand_styles,  :include => :style
  has_many                      :styles,        :through => :brand_styles
  accepts_nested_attributes_for :brand_styles,  :allow_destroy => true

  # has_many                      :components     :thourgh => :style;

  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
