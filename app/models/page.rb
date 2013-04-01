# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  header     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skin_id    :string(255)
#

class Page < ActiveRecord::Base
  attr_accessible :skin_id, :section_id, :name, :title, :content

  belongs_to :skin
  belongs_to :section

  has_one :category, :through => :section
  
  validates_presence_of :skin
  validates_presence_of :section
end
