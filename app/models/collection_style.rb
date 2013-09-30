class CollectionStyle < ActiveRecord::Base
  attr_accessible :collection_id, 
                  :style_id

  belongs_to      :collection
  belongs_to      :style

  validates       :collection_id, presence: true
  validates       :style_id,      presence: true
end
