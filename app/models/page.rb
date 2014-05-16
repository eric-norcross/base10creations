# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  header     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skin_id    :string(255)
#

class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id                   :title, use: [:slugged, :history]

  default_scope order('pages.title ASC')
                              ## DB Backed ##
  attr_accessible               :title, 
                                :content,
                                :slug,

                                ##belongs_to##
                                  :skin_id,

                              ## has_one ##

                              ## has_many ##

                              ## nested attributes ##
                                :images_attributes,
                                :figures_attributes,
                                :carousels_attributes

  belongs_to                    :skin
  
  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  has_many                      :carousels, dependent: :destroy
  accepts_nested_attributes_for :carousels, allow_destroy: true #, reject_if: lambda { |a| a[:image].blank?}

  has_many                      :figures, as: :figurable, dependent: :destroy
  accepts_nested_attributes_for :figures, reject_if: lambda { |a| a[:link].blank?}, allow_destroy: true

  validates                     :title, 
                                presence: true,
                                format: { with: /^[a-zA-Z\d\s]*$/ }

  validates                     :skin,
                                presence: true

  def name
    title.parameterize
  end
  
  private
  
  
end
