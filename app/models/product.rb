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

                                ## belongs_to ##
                                :component_id,
                                :subcomponent_id,
                                :collection_id,
                                :skin_id,

                                ## has_many ##

                                ## nested attributes ##
                                :skus_attributes,
                                :dimensions_attributes,
                                :image_attributes
                        

  belongs_to                    :component
  belongs_to                    :subcomponent
  belongs_to                    :collection
  belongs_to                    :skin

  has_many                      :dimensions, dependent: :destroy
  accepts_nested_attributes_for :dimensions, reject_if: lambda { |a| a[:width].blank? }, allow_destroy: true

  has_many                      :skus, dependent: :destroy
  accepts_nested_attributes_for :skus, reject_if: lambda { |a| a[:title].blank? }, allow_destroy: true
  
  has_many                      :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  validates_presence_of         :title
  validates_presence_of         :collection
  validates_presence_of         :skin

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
    # self.name = component.title.parameterize
  end
end
