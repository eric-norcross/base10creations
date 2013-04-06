# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :text
#  sku        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skin_id    :integer
#

class Product < ActiveRecord::Base
  default_scope order('id ASC')
  
  attr_accessible :name, :sku, :skin_id
  belongs_to :skin
  validates_presence_of :skin
end
