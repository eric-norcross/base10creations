class BrandStyle < ActiveRecord::Base
  attr_accessible :brand_id, 
                  :style_id

  belongs_to      :brand
  belongs_to      :style

  validates       :brand_id,    presence: true
  validates       :style_id,    presence: true
end