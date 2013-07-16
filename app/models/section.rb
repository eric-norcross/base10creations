class Section < ActiveRecord::Base
  default_scope order('sections.id ASC')
  
  attr_accessible               :name, 
                                :title, 
                                :content,
                                :parent_id,

                                ##belongs_to##
                                :skin_id

                                ##has_many##
  #                               :subsection_ids



  # has_many                      :subsections

  belongs_to                    :skin

  validates_presence_of         :skin
  validates_presence_of         :title

  before_save                   :create_name

  def parent
    @parent = Section.find(parent_id)
    return @parent
  end

  def children
    @children = Section.all(:conditions => { :parent_id => id })
    return @children
  end

  private
  
  def create_name
    self.name = title.parameterize
  end
end