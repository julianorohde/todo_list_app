# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.2"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Adds safeguards to prevent dangerous database migrations
gem "strong_migrations", "~> 2.1"

gem 'devise', '~> 4.9', '>= 4.9.4'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Factory bot for setting up Ruby objects as test data
  gem "factory_bot_rails", "~> 6.4", ">= 6.4.4"

  # Faker gem to generate fake data for testing and development
  gem "faker", "~> 3.5", ">= 3.5.1"

  gem 'mocha', '~> 2.7', '>= 2.7.1'

  # Debugging tool for the Rails console
  gem "pry-rails", "~> 0.3.11"

  # Gem for enhancing controller testing
  gem "rails-controller-testing"

  # Gems for code quality, performance improvements, and adherence to Rails standards
  gem "rubocop", "~> 1.69", ">= 1.69.2"
  gem "rubocop-performance", "~> 1.23"
  gem "rubocop-rails", "~> 2.27"
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-minitest", "~> 0.36.0"

  # Provides additional matchers for testing with RSpec
  gem "shoulda-matchers", "~> 6.4"

  # Code coverage analysis tool for measuring test coverage
  gem "simplecov", "~> 0.22.0"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-context"
end
