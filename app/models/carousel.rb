class Carousel < ActiveRecord::Base
  attr_accessible               :name, 
                                :title,

                                ## belongs_to ##
                                :page_id,

                                ## has_one ##

                                ## has_many ##

                                ## nested attributes ##
                                :figures_attributes

  belongs_to                    :page

  has_many                      :figures, dependent: :destroy
  accepts_nested_attributes_for :figures, reject_if: lambda { |a| a[:link].blank?}, allow_destroy: true

  # validates_presence_of         :title

  # before_save                   :create_name

  # private
  
  # def create_name
  #   self.name = title.parameterize
  # end
  
end
