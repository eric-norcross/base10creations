class Image < ActiveRecord::Base
  default_scope order('images.id ASC')

  attr_accessible               :asset,
                                :asset_cache

  belongs_to                    :imageable, polymorphic: true

  mount_uploader                :asset, ImageUploader
end
