[gem]: https://rubygems.org/gems/dry-system-rails
[travis]: https://travis-ci.org/dry-rb/dry-system-rails
[gemnasium]: https://gemnasium.com/dry-rb/dry-system-rails
[codeclimate]: https://codeclimate.com/github/dry-rb/dry-system-rails
[coveralls]: https://coveralls.io/r/dry-rb/dry-system-rails
[inchpages]: http://inch-ci.org/github/dry-rb/dry-system-rails

# dry-system-rails [![Join the chat at https://gitter.im/dry-rb/chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dry-rb/chat)

[![Gem Version](https://badge.fury.io/rb/dry-system-rails.svg)][gem]
[![Build Status](https://travis-ci.org/dry-rb/dry-system-rails.svg?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dry-rb/dry-system-rails.svg)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dry-rb/dry-system-rails/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/dry-rb/dry-system-rails/badges/coverage.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/dry-rb/dry-system-rails.svg?branch=master)][inchpages]

Railtie for dry-system (つ◕౪◕)つ━☆ﾟ.*･｡ﾟ

## Installation

Add it to your Gemfile:

```
gem 'dry-system-rails'
```

Assuming your `Rails.application.class` is `MyApp::Application`, add `config/system/import.rb`
file with the following content:

``` ruby
# config/system/import.rb
module MyApp
  Import = Container.injector
end
```

To configure auto-registration create `config/initializer/system.rb` with the following content:

``` ruby
require 'dry/system/rails'

Dry::System::Rails.configure do |config|
  # you can set it to whatever you want and add as many dirs you want
  config.auto_register << 'lib'
end
```

Now you can use `MyApp::Import` to inject components into your objects:

``` ruby
# lib/user_repo.rb
class UserRepo
end

# lib/create_user.rb
require 'import'

class CreateUser
  include Import['user_repo']
end
```

## TODO

This is super alpha and it's missing a couple of things:

* Support for code reloading in dev mode
* Some generators to make UX nicer
* Tests for loading scripts (console etc)
* Tests for running rake tasks

## License

See `LICENSE` file.
