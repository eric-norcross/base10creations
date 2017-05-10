source 'https://rubygems.org'

# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

# Config
  gem 'figaro'

# Platform
  ruby "2.4.0" # Required for Heroku deployment
  gem 'rails', '~> 5.1.0'

# Database
  gem 'pg', '~> 0.18'
  gem 'nilify_blanks'
  # gem 'redis', '~> 3.0' # Use Redis adapter to run Action Cable in production

# Hosting, Server & Deployment
  gem 'puma', '~> 3.7'
  gem 'foreman'
  gem 'rack-rewrite' # Redirecting naked domains to "www"
  gem 'friendly_id', '~> 4.0.10' # SEO
  gem 'turbolinks', '~> 5'
  gem 'rails_12factor' # To silence Heroku deprecation warning
  
# View
  gem 'haml'

# Authorization & Authentication
  # gem 'cancan'
  # gem 'devise'

# Monitoring & Logging
  gem 'newrelic_rpm'
  # gem 'lograge'

# Image Serving & Uploading
  # gem 'carrierwave'
  # gem 'cloudinary'

# Forms
  # gem 'cocoon'
  # gem 'ckeditor', '4.2.0'
  # gem 'mini_magick'
  # gem 'mail_form'

# See https://github.com/rails/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  # gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
  # gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'awesome_print', :require => 'ap'
  gem 'better_errors'
  gem 'binding_of_caller'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # gem 'coffee-rails', '~> 4.2'

  # Database
  gem 'seed_dump'
  gem 'annotate'

  # Gems used only for assets and not required in production environments by default.
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
