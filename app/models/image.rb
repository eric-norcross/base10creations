class Image < ActiveRecord::Base
  attr_accessible               :asset,
                                :asset_cache

  belongs_to                    :imageable, polymorphic: true

  mount_uploader                :asset, ImageUploader
end
