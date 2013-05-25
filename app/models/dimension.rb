class Dimension < ActiveRecord::Base
  default_scope order('dimensions.id ASC')
  attr_accessible               :name,
                                :title,
                                :width, 
                                :height,
                                :depth,
                                :image,

                                ##belongs_to##
                                :product_id

                                ##has_many##                 

  belongs_to                    :product

  validates_presence_of         :title
  validates_presence_of         :width
  validates_presence_of         :height
  validates_presence_of         :depth

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end