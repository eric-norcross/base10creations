class Brand < ActiveRecord::Base
  default_scope order('brands.id ASC')

  attr_accessible               :name, 
                                :title,
                                :style_ids

  has_many                      :styles

  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
