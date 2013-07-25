class ProductCompilationComponent < ActiveRecord::Base
  attr_accessible :product_id, 
                  :compilation_id,
                  :component_id

  belongs_to      :product
  belongs_to      :compilation
  belongs_to      :component
end
