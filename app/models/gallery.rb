class Gallery < ActiveRecord::Base
  attr_accessible                :image

  has_many                       :images
  
end
