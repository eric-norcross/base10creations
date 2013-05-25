# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :text
#  sku        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skin_id    :integer
#

class Product < ActiveRecord::Base
  default_scope order('id ASC')
  
  attr_accessible               :name, 
                                :title,
                                :features, 
                                :style,
                                :video,

                                ##belongs_to##
                                :collection_id,
                                :skin_id,

                                ##has_many##
                                :skus_attributes,
                                :dimensions_attributes
                                #:images_attributes
                        

  belongs_to                    :collection
  belongs_to                    :skin

  has_many                      :dimensions, :dependent => :destroy
  accepts_nested_attributes_for :dimensions, :reject_if => lambda { |a| a[:width].blank? }, :allow_destroy => true

  has_many                      :skus, :dependent => :destroy
  accepts_nested_attributes_for :skus, :reject_if => lambda { |a| a[:identifier].blank? }, :allow_destroy => true

  # mount_uploader                :image, ImageUploader
  
  validates_presence_of         :title
  validates_presence_of         :collection
  validates_presence_of         :skin

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
