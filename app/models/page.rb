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
  default_scope order('pages.title ASC')
  
  attr_accessible       :name, 
                        :title, 
                        :content,

                        ##belongs_to##
                        :skin_id, 
                        :subsection_id

                        ##has_many##

                        

  belongs_to            :skin
  belongs_to            :subsection

  #has_one :section,    :through => :subsection
  
  validates_presence_of :skin
  #validates_presence_of :subssection #Pages can be stand alone

  before_save           :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
