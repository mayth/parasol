source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '4.2.0'

gem 'therubyracer', platforms: :ruby

gem 'pg'

# stylesheets (sass/less)
gem 'sass-rails'
gem 'less-rails'
gem 'yui-compressor'

# framework
gem 'purecss'

# javascript (coffeescript, jquery, ...)
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder'
gem 'uglifier'

# view template (haml)
gem 'haml-rails'

# markdown
gem 'redcarpet'
gem 'marked-rails'

# monitor
gem 'newrelic_rpm'
gem 'coveralls', require: false

# process manager
gem 'foreman'
# app configuration
gem 'figaro'
gem 'rails-settings-cached'

## model
# migration DSL
gem 'migrant'
# tag
gem 'acts-as-taggable-on'
# timeline validation
gem 'validates_timeliness'

## view
# i18n
gem 'rails-i18n'
# automatically insert validation to views
gem 'html5_validators'
gem 'nested_form'
# truncate HTML
gem 'truncate_html'

# authentication
gem 'devise'

# Use unicorn as the app server
gem 'unicorn'

### environment specific gems

group :development do
  gem 'yard', require: false
  gem 'yard-activerecord', require: false
  gem 'brakeman', require: false
  gem 'guard-brakeman'
  gem 'bullet'
end

group :test do
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
end

group :development, :test do
  # preloader
  gem 'spring'
  gem 'spring-commands-rspec'

  # suppress assets log!
  gem 'quiet_assets'

  # pry
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-doc'

  # pretty error messages
  gem 'better_errors'
  gem 'binding_of_caller'

  # output highlighter/formatter
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'

  # RSpec
  gem 'rspec-rails'
  gem 'rake_shared_context'

  # fixture-replacement
  gem 'factory_girl_rails'

  # cleanup testing DB
  gem 'database_rewinder'

  # Guard (automatic run tests)
  gem 'guard-rspec'
end
