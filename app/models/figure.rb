class Figure < ActiveRecord::Base
  default_scope order('figures.id ASC')

  attr_accessible               :caption,
                                :link,

                                ## belongs_to ##
                                # :page_id,
                                # :brand_id,
                                
                                ## has_many ##

                                ## nested attributes ##
                                :images_attributes

  belongs_to                    :figurable, polymorphic: true
  
  # belongs_to                    :page
  # belongs_to                    :brand

  has_many                      :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  # validates_presence_of         :images
end