class Video < ActiveRecord::Base
  default_scope order('videos.id ASC')
  attr_accessible               :url,

                                ##belongs_to##
                                :product_id

  belongs_to                    :product

  validates_presence_of         :url
end
