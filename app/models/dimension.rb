class Dimension < ActiveRecord::Base
  default_scope order('dimensions.id ASC')
  attr_accessible               :name,
                                :title,
                                :width, 
                                :height,
                                :depth,

                                ##belongs_to##
                                :product_id,

                                ##has_many##
                                :image_attributes
                                              

  belongs_to                    :product

  has_many                      :image, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  # validates_presence_of         :image
  validates_presence_of         :title
  validates_presence_of         :width
  validates_presence_of         :height
  validates_presence_of         :depth

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end