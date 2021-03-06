source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'

gem 'pg_search', "~> 0.5.7"

gem 'will_paginate'

gem 'sidekiq', '~> 3.5.0'
# gem 'sidekiq-status'
gem 'redis-namespace'

gem 'sinatra', require: false

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', github: 'rails/turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'foundation-rails'
gem 'foundation-datetimepicker-rails'

# sidekiq work don't support http access and message_bus,so now use ajax sync status.
#gem 'message_bus'
#gem 'puma'

gem 'simple_form'

gem 'devise'

gem 'slim-rails'

#gem 'google-api-client', '~> 0.9.pre'

# force type
gem 'kortype', github: 'arnkorty/kortype'

gem 'font-awesome-sass'

gem "paranoia", "~> 2.0"
gem 'paranoia_uniqueness_validator', '1.1.0'

gem 'stringex'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'quiet_assets'
  gem "ruby-prof"
  gem "better_errors"
  gem 'meta_request'
  gem "binding_of_caller"
  gem 'spring'
  gem 'rails_layout'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  #gem 'selenium-webdriver'
  gem "capybara"
  gem "guard-rspec", "~> 4.2.8"
  gem 'shoulda'
  gem 'activerecord-nulldb-adapter'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'rack-livereload'
  gem 'guard-livereload'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'mina-sidekiq'
end
