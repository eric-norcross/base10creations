class Finish < ActiveRecord::Base
  default_scope order('finishes.id ASC')
  attr_accessible               :name, 
                                :title,

                                ##belongs_to##
                                :sku_id,

                                ##has_many##
                                :image_attributes


  belongs_to                    :skus

  has_one                       :image, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }

  validates_presence_of         :image
  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
