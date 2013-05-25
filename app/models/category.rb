class Category < ActiveRecord::Base
  default_scope order('id ASC')

  # CATEGORY_KINDS = [["Product", 0],["Page", 1]]

  # scope :products, where(:kind => 0)
  # scope :pages, where(:kind => 1)
  
  attr_accessible       :name, 
                        :title, 

                        ##belongs_to##

                        ##has_many##
                        :component



  has_many              :components

  validates_presence_of :title

  before_save           :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end