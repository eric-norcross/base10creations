require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Base10Creations
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil


    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Customized
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      # Change mail delvery to either :smtp, :sendmail, :file, :test
      config.action_mailer.delivery_method  = :smtp
      config.action_mailer.smtp_settings    = {
        address:              ENV["EMAIL_SMTP_ADDRESS"],
        port:                 ENV["EMAIL_SMTP_PORT"],
        domain:               ENV["EMAIL_DOMAIN"],
        authentication:       ENV["EMAIL_SMTP_AUTH_TYPE"],
        enable_starttls_auto: ENV["EMAIL_SMTP_ENABLE_TTLS"],
        user_name:            ENV["EMAIL_USERNAME"],
        password:             ENV["EMAIL_PASSWORD"]
      }

      # specify what domain to use for mailer URLs
      config.action_mailer.default_url_options = { host: "localhost:8080" }

      config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
        r301 '/assets/tracker-b1442e85b03bdcaf66dc58c7abb98745dd2687d86350be9a298a1d9382ac849b.gif', '/trackers/1'
      end
  end
end
