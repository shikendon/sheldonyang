source 'https://rubygems.org'

# Ruby version
ruby '2.1.5'

# Heroku Ruby Support
group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'dalli'
  gem 'memcachier'
end

# Use kaminari as paginator
gem 'kaminari'
# Use nokogiri as HTML parser
gem 'nokogiri'
# Use devise as authentication solution
gem 'devise'
# Use omniauth as authentication solution
gem 'omniauth'
# Use omniauth-github as GitHub OAuth2 strategy
gem 'omniauth-github'
# Use omniauth-twitter as Twitter OAuth2 strategy
gem 'omniauth-twitter'
# Use omniauth-facebook as Facebook OAuth2 strategy
gem 'omniauth-facebook'
# Use omniauth-google-oauth2 as Google OAuth2 strategy
gem 'omniauth-google-oauth2'
# Use omniauth-yahoo as Yahoo OAuth2 strategy
gem 'omniauth-yahoo'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', groups: [:development, :test]
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'coffee-script-source', '1.8.0', groups: [:development, :test]
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn', platforms: :ruby

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
