class ContactMailer < ActionMailer::Base
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.get_in_touch.subject
  #
  
  def format(model, requirements)
    @model = model

    mail to: model.to, from: model.from, subject: model.subject
  end
end
