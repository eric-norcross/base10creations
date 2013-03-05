class Page < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :header, :name, :template

  friendly_id :name, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    new_record?
  end


end
