source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.6'
# Use SCSS for stylesheets
#gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use puma in production
gem 'puma'

# Use rack-timeout to kill long-running processes, heroku timeouts in 30s but can't tell puma it happened
gem "rack-timeout", require: "rack/timeout/base"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use postgresql as the database for Active Record
gem 'pg'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Add bootstrap
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

# Use HAML templating engine
gem 'haml-rails'

gem 'mini_racer'

gem 'dotenv-rails'

# Temporary failure fix, check if you can remove in the future
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use sqlite3 as the database for Active Record
  # gem 'sqlite3'

  # %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
  #     gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main' # Previously '4-0-dev' or '4-0-maintenance' branch
  # end
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webdrivers'

  # Pretty print
  gem "awesome_print"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # gem 'capistrano', require: false
  # gem 'capistrano-rbenv', require: false
  # gem 'capistrano-rails', require: false
  # gem 'capistrano-bundler', require: false
  # gem 'capistrano3-puma', require: false
end

group :production do
  # Enable all platform functionality in heroku, like logging
  # gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '3.1.2'
