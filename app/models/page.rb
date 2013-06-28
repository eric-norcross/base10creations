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
  default_scope order('pages.title ASC')
  
  attr_accessible               :name, 
                                :title, 
                                :content,

                                ##belongs_to##
                                :skin_id, 

                                ## has_one ##

                                ## has_many ##

                                ## nested attributes ##
                                :images_attributes,
                                :figures_attributes

                        
  belongs_to                    :skin

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  has_many                      :figures, dependent: :destroy
  accepts_nested_attributes_for :figures, reject_if: lambda { |a| a[:caption].blank? && a[:image].blank?}, allow_destroy: true

  validates_presence_of         :skin

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
