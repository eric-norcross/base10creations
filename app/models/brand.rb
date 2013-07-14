class Brand < ActiveRecord::Base
  default_scope order('brands.title ASC')

  attr_accessible               :name, 
                                :title,

                                ##belongs_to##

                                ##has_many##
                                :style_ids,

                                ## nested attributes ##
                                :images_attributes

  has_many                      :styles

  has_many                      :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true


  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end
end
