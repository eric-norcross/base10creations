# == Schema Information
#
# Table name: skins
#
#  id         :integer          not null, primary key
#  name       :text
#  template   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skin < ActiveRecord::Base
  attr_accessible :product, :page, :name, :template
  has_many :products
  has_many :pages
end
