class Finish < ActiveRecord::Base
  default_scope order('finishes.id ASC')
  attr_accessible               :name,
                                :title,

                                ## belongs_to ##

                                ## has_many ##
                                :sku,

                                ## nested attributes ##
                                :image_attributes


  has_many                      :skus

  has_many                      :image, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  validates_presence_of         :image
  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end