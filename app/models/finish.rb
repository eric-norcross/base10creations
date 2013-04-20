class Finish < ActiveRecord::Base
  default_scope order('finishes.id ASC')
  attr_accessible         :collection_id,
                          :name, 
                          :title,
                          :image

  belongs_to              :collection

  validates_presence_of   :title

  before_save             :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
