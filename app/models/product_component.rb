class ProductComponent < ActiveRecord::Base
  attr_accessible :product_id, 
                  :component_id

  belongs_to      :product
  belongs_to      :component

  validates       :product_id,    presence: true
  validates       :component_id,  presence: true
end
