class Image < ActiveRecord::Base
  default_scope order('images.id ASC')

  attr_accessible               :asset,
                                :asset_cache

  belongs_to                    :imageable, polymorphic: true

  mount_uploader                :asset, ImageUploader

  def default
    return {asset: "v1375725611/default_image_p8yvwn.jpg"}
  end
end
