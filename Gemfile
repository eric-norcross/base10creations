source 'https://rubygems.org'

# Platform
ruby '2.0.0'
gem 'rails', '3.2.17'

# View Tools
gem 'jquery-rails'
gem 'haml-rails'
gem 'font-awesome-rails'

# DB Tools
gem 'pg'
gem 'seed_dump'
gem 'annotate', '>=2.5.0'

# Image/File Serving & Uploading
gem 'ckeditor', '4.0.6'
gem 'carrierwave'
gem 'mini_magick'
gem 'cloudinary'

# Authorization & Authentication
# gem 'cancan'
# gem 'devise'

# Monitoring & Logging
# gem 'newrelic_rpm'
# gem 'lograge'

# Hosting, Serving & Deployment
gem 'unicorn'
gem 'rails_12factor' # To silence Heroku deprecation warning
# gem 'capistrano'


# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  # gem 'turbo-sprockets-rails3'
end

group :development do
  gem 'awesome_print', :require => 'ap'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :development, :test do
  gem "rspec-rails"
  gem 'factory_girl_rails', "~> 4.0"
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
