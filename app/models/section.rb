class Section < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('sections.id ASC')
  
  attr_accessible               :name, 
                                :title, 
                                :content,
                                :link,
                                :parent_id,
                                :active,

                                ##belongs_to##
                                :skin_id

                                ##has_many##

  belongs_to                    :skin

  
  validates_presence_of         :title
  validates                     :link, :format => /(^$)|(^(http:\/\/|https:\/\/|\/))/ix
  validates_presence_of         :skin
  validate                      :cannot_assign_to_self

  before_save                   :create_name

  before_destroy                :update_children

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

  def update_children
    children.each do |child|
      child.update_attributes(:parent_id => 0, :active => false)
    end
  end
  
  def parent
    if !parent_id || parent_id == 0
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

  def path
    if link && link != ""
      @path = link;
    else 
      @path = section_path(id)
    end

    return @path
  end

  private
  
  def create_name
    self.name = title.parameterize
  end
end