class Sku < ActiveRecord::Base
  default_scope order('skus.id ASC')

  attr_accessible               :identifier,

                                ## belongs_to ##
                                :product_id,

                                ## has_one ##
                                :finish_id,

                                ## has_many ##
                                # :finish_ids,

                                ## polymorphic ##
                                :images_attributes

  belongs_to                    :product
  belongs_to                    :finish

  has_many                      :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  #validates_presence_of         :images

end
