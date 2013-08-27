class Location < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('locations.name ASC')

  acts_as_gmappable             

  attr_accessible               :name,
                                :address, 
                                :city,
                                :province,
                                :postal_code,
                                :country,
                                :phone,
                                :ext,
                                :phone_alt,
                                :ext_alt,
                                :url, 
                                :latitude, 
                                :longitude 

  geocoded_by                   :address

  validates_presence_of         :name
  validates_presence_of         :address
  validates_presence_of         :city
  validates_presence_of         :province
  validates_presence_of         :postal_code
  validates_presence_of         :country

  
  after_validation              :geocode


  def gmaps4rails_address
    "#{self.address} #{self.city} #{self.province} #{self.postal_code} #{self.country}" 
  end                          
end
