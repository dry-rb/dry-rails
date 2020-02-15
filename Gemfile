# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

eval_gemfile 'Gemfile.devtools'

gem 'dry-system', github: 'dry-rb/dry-system', branch: 'master'

group :test do
  gem 'railties'
  gem 'actionpack'
end

group :tools do
  gem 'byebug', platform: :ruby
end
