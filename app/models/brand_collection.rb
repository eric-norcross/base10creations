class BrandCollection < ActiveRecord::Base
  attr_accessible :brand_id, 
                  :collection_id

  belongs_to      :brand
  belongs_to      :collection
end
