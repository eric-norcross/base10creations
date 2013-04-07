class Category < ActiveRecord::Base
  default_scope order('id ASC')
  scope :products, where(:kind => 0)
  scope :pages, where(:kind => 1)
  
  attr_accessible :section, :component, :name, :title, :kind

  has_many :sections
  has_many :components

  CATEGORY_KINDS = [["Product", 0],["Page", 1]]

  #before_create :record_signup
  before_save   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end