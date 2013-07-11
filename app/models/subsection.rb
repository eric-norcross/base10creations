class Subsection < ActiveRecord::Base
  default_scope order('subsections.title ASC')
  
  attr_accessible               :page, 
                                :name, 
                                :title, 
                                :content,

                                ## belongs_to ##
                                :section_id, 
                                :skin_id,

                                ##has_many##
                                :page_ids

  belongs_to                    :section
  belongs_to                    :skin

  has_many                      :pages
  
  validates_presence_of         :section
  validates_presence_of         :skin
  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end