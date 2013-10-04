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

  has_many                      :figures, as: :figurable, dependent: :destroy
  accepts_nested_attributes_for :figures, reject_if: lambda { |a| a[:link].blank?}, allow_destroy: true
end