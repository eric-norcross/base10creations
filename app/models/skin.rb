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
  default_scope order('skins.title ASC')
  
  attr_accessible               :name, 
                                :title,
                                :template,

                                ##belongs_to##

                                ##has_many##
                                :product_ids,
                                :page_ids


  has_many                      :products
  has_many                      :pages
  has_many                      :complilations
  has_many                      :sections

  validates_presence_of         :title
  validates_presence_of         :template

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
