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
    @pid = parent_id

    if @pid.blank? || @pid == 0
      @pid = id
    end

    @parent = Section.find(@pid)
    return @parent
  end

  def get_top_level(section = self)
    if section.parent_id && section.parent_id != 0
      section = section.get_top_level(Section.find(section.parent_id))
    end

    return section
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