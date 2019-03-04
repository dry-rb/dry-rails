[gem]: https://rubygems.org/gems/dry-system-rails
[travis]: https://travis-ci.org/dry-rb/dry-system-rails
[codeclimate]: https://codeclimate.com/github/dry-rb/dry-system-rails
[coveralls]: https://coveralls.io/r/dry-rb/dry-system-rails
[inchpages]: http://inch-ci.org/github/dry-rb/dry-system-rails

# dry-system-rails [![Join the chat at https://gitter.im/dry-rb/chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dry-rb/chat)

[![Gem Version](https://badge.fury.io/rb/dry-system-rails.svg)][gem]
[![Build Status](https://travis-ci.org/dry-rb/dry-system-rails.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/dry-rb/dry-system-rails/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/dry-rb/dry-system-rails/badges/coverage.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/dry-rb/dry-system-rails.svg?branch=master)][inchpages]

Railtie for dry-system (つ◕౪◕)つ━☆ﾟ.*･｡ﾟ

## Installation

Add it to your Gemfile:

```
gem 'dry-system-rails'
```

## Usage

To configure auto-registration create `config/initializer/system.rb` with the following content:

``` ruby
Dry::System::Rails.configure do |config|
  # you can set it to whatever you want and add as many dirs you want
  config.auto_register << 'lib'
end
```

The `Dry::System::Rails::Railtie` creates a container and injector on your behalf at runtime and assign them to two constants `Container` and `Import`
under your applications root module. E.g. if your application is named `MyApp`, the `Railtie` will add the following constants:

* `MyApp::Container`
* `MyApp::Import`

Now you can use `MyApp::Import` to inject components into your objects and framework components:

``` ruby
# lib/user_repo.rb
class UserRepo

end

# lib/create_user.rb
class CreateUser
  include MyApp::Import['user_repo']
end

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  include MyApp::Import['create_user']
end
```

## Working with Framework Dependencies

The Rails API is designed around the usage of class methods. If you choose to write domain logic in objects you will likely encounter a situation where your code will have to use one of the framework components.  That is where manual registration using [bootable dependency](https://dry-rb.org/gems/dry-system/booting) will come in handy.

E.g. You have an object `CreateWidget` that needs to process widgets asynchronously with an `Widgets:NotificationJob` but you want to leverage dependency injection to decouple the components:

```ruby
# config/initializer/system.rb
Dry::System::Rails.configure do |config|
  config.auto_register << 'lib'
end

# app/jobs/widgets/notification_job.rb
class Widgets::NotificationJob < ApplicationJob
end

# config/system/boot/application.rb
# Use bootable componets to manually register framework dependencies
MyApp::Container.boot(:application) do |app|
  setup do
    app.namespace(:widgets) do |widgets|
      widgets.register(:notification, memoize: true) { Widgets::NotificationJob }
    end
  end
end

# lib/create_widget.rb
class CreateWidget
  include MyApp::Import[job: 'widgets.notification']

  def call(args)
    # some logic that creates a widget command
    job.perform_later(create_widget_command)
  end
end
```

## TODO

This is super alpha and it's missing a couple of things:

* Some generators to make UX nicer
* Tests for loading scripts (console etc)
* Tests for running rake tasks

## License

See `LICENSE` file.
