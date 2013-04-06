class Category < ActiveRecord::Base
  default_scope order('id ASC')
  
  attr_accessible :section, :name, :title, :kind

  has_many :sections
  has_many :products

  CATEGORY_TYPES = [["Prodcut",0],["Page",1]]

  #before_create :record_signup
  before_save   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end