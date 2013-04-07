class Component < ActiveRecord::Base
  default_scope order('id ASC')

  attr_accessible       :category_id, 
                        :name, 
                        :title

  belongs_to            :category
  
  validates_presence_of :category
  validates_presence_of :title

  before_save           :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
