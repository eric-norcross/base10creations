class Section < ActiveRecord::Base
  default_scope order('sections.id ASC')
  
  attr_accessible               :name, 
                                :title, 
                                :content,
                                :parent_id,

                                ##belongs_to##
                                :skin_id

                                ##has_many##

  belongs_to                    :skin

  validates_presence_of         :skin
  validates_presence_of         :title
  validate                      :cannot_assign_to_self

  before_save                   :create_name

  def cannot_assign_to_self
    errors.add :base, "You cannot add a Section as a parent of it's self." if self.parent_id == self.id
  end

  def patriarch
    if parent_id == 0
      return self
    else 
      return parent.patriarch
    end
  end
  
  def parent
    if parent_id == 0
      return nil
    else 
      return Section.find(parent_id)
    end
  end

  def children
    return Section.where(parent_id: id)
  end

  def siblings
    if parent_id == 0
      return Section.where(parent_id: parent_id)
    else
      return parent.children
    end
  end


  private
  
  def create_name
    self.name = title.parameterize
  end
end