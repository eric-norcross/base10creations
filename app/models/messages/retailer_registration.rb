class RetailerRegistration
  include ActiveAttr::Model
  
  attribute             :retailer_number
  attribute             :company
  attribute             :address
  attribute             :city
  attribute             :province
  attribute             :postal_code
  attribute             :name
  attribute             :email
  attribute             :email_confirmation
  attribute             :phone
  attribute             :fax
  
  # attr_accessible       :retailer_number,
  #                       :company,
  #                       :address,
  #                       :city,
  #                       :province,
  #                       :postal_code,
  #                       :name,
  #                       :email,
  #                       :email_confirmation,
  #                       :phone,
  #                       :fax

  validates_presence_of :retailer_number
  validates_presence_of :company
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :province
  validates_presence_of :postal_code
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :email_confirmation
  validates_presence_of :phone

  validates_format_of   :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i


  def validate_postal_code
  end

  def validate_phone
  end

  def validate_email
  end

  def confirm_email
  end

  #helpers

  def to
    return "rafaelcarrillo@martinfurniture.com"
    #return "eric@base10creations.com" 
  end

  def from
    return "MartinFurniture.com - Retailer Registration <info@martinfurniture.com>"
  end

  def subject
    return "Retailer Registration"
  end

  def success
    return "Your registration request has been sent successfully. We will contact you shortly with confirmation and further instructions."
  end
end