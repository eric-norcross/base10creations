class ComponentStyle < ActiveRecord::Base
  attr_accessible :component_id, 
                  :style_id

  belongs_to      :component
  belongs_to      :style
end
