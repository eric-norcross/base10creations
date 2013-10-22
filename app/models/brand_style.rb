class BrandStyle < ActiveRecord::Base
  attr_accessible :brand_id, 
                  :style_id

  belongs_to      :brand
  belongs_to      :style
end