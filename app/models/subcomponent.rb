class Subcomponent < ActiveRecord::Base
  default_scope order('subcomponents.title ASC')
  
  attr_accessible       :name, 
                        :title,

                        ##belongs_to##
                        :component_id

                        ##has_many##

  belongs_to            :component
  
  validates_presence_of :component
  validates_presence_of :title

  before_save           :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
