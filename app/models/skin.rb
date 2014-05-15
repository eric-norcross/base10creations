class Skin < ActiveRecord::Base
  default_scope order('skins.title ASC')
                                
                                ## DB Backed ##
  attr_accessible               :name, 
                                :title,
                                :template

  has_many                      :pages

  validates                     :title, 
                                presence: true,
                                format: { with: /^[a-zA-Z\d\s]*$/ }

  validates                     :template, 
                                presence: true,
                                format: { with: /^[a-zA-Z_\d\/]*$/ }

  before_save                   :create_name
  
  private
  
    def create_name
      self.name = title.parameterize
    end
end
