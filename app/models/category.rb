class Category < ActiveRecord::Base
  attr_accessible :section, :name, :title

  has_many :sections
end