source 'https://rubygems.org'

gem 'rails', '4.0.3'

gem 'therubyracer', platforms: :ruby

gem 'pg'

# stylesheets (sass)
gem 'sass-rails', '~> 4.0.0'
gem 'yui-compressor'

# javascript (coffeescript, jquery, ...)
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'uglifier', '>= 1.3.0'

# view template (haml)
gem 'haml-rails'

# framework
gem 'semantic-ui-rails'

# markdown
gem 'redcarpet'
gem 'showdown-rails'

# monitor
gem 'newrelic_rpm'

# process manager
gem 'foreman'
# app configuration
gem 'figaro'

## model
# migration DSL
gem 'migrant'
# tag
gem 'acts-as-taggable-on'
# timeline validation
gem 'validates_timeliness', '~> 3.0'

## view
# i18n
gem 'rails-i18n', '~> 4.0.0'
# automatically insert validation to views
gem 'html5_validators'

# authentication
gem 'devise'

# Use unicorn as the app server
gem 'unicorn'

### environment specific gems

group :development do
  gem 'erb2haml'
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
  gem 'guard-spring'
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
