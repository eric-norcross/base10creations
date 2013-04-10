class CollectionComponent < ActiveRecord::Base
  attr_accessible :collection_id, 
                  :component_id

  belongs_to      :collection
  belongs_to      :component
end
