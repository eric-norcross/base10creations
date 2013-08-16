class ContactMailer < ActionMailer::Base
  default from: "info@martinfurniture.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.get_in_touch.subject
  #
  def get_in_touch(fields)
    @fields = fields

    mail to: fields.email, subject: fields.subject
  end
end
