class Figure < ActiveRecord::Base
  default_scope order('figures.id ASC')

  attr_accessible               :caption,

                                ## belongs_to ##
                                :page_id,
                                ## has_many ##

                                ## nested attributes ##
                                :image_attributes


  has_many                      :skus

  has_many                      :image, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  validates_presence_of         :image
  validates_presence_of         :caption

  # before_save                   :create_name

  # private
  
  # def create_name
  #   self.name = caption.parameterize
  # end
end