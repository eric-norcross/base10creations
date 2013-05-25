class Finish < ActiveRecord::Base
  default_scope order('finishes.id ASC')
  attr_accessible         :name, 
                          :title,

                          ##belongs_to##
                          :sku_id

                          ##has_many##
                          


  belongs_to              :skus

  validates_presence_of   :title

  before_save             :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
