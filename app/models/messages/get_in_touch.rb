class GetInTouch
  include ActiveAttr::Model
  
  attribute               :name
  attribute               :email
  attribute               :phone
  attribute               :subject
  attribute               :content
  
  # attr_accessible         :name, 
  #                         :email, 
  #                         :phone, 
  #                         :subject, 
  #                         :content

  validates_presence_of   :email
  validates_presence_of   :subject
  validates_format_of     :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of     :content, :maximum => 500

  def to
    return "info@martinfurniture.com"
    #return "eric@base10creations.com" 
  end

  def from
    return "MartinFurniture.com - Get in Touch form <info@martinfurniture.com>"
  end

  def success
    return "Message sent! Thank you for contacting us."
  end

end