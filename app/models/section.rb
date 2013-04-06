class Section < ActiveRecord::Base
  attr_accessible :category_id, :skin_id, :page, :name, :title, :content

  has_many :pages

  belongs_to :category
  belongs_to :skin
  
  validates_presence_of :category
  validates_presence_of :skin
  validates_presence_of :name
  validates_presence_of :title

  before_save   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end