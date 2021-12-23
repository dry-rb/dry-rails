---
title: Introduction
description: The dry-rb railtie
layout: gem-single
order: 7
type: gem
name: dry-rails
---

^INFO
Before dry-rails hits 1.0.0 it should be considered as beta software. Various usage patterns should emerge as more people try it out, so please do so and provide feedback!
^

`dry-rails` is the official dry-rb railtie for Ruby on Rails framework. It provides an application container using `dry-system` with additional features:

- `:safe_params` - a small controller extension that adds the ability to define schemas for controller actions
- `:application_contract` - sets up `ApplicationContract` class for you
- `:controller_helpers` - convenient methods for working with the application container

## Installation

To generate a new application skeleton with `dry-rails` installed, you can use the default template provided by the gem. Here's a minimalistic example:

```bash
rails new my_app -MOPCSJT --template https://raw.githubusercontent.com/dry-rb/dry-rails/master/templates/default.rb
```

If you already have a Rails application, simply add `dry-rails` to your `Gemfile`:

```ruby
gem "dry-rails", "~> 0.3"
```

## Overview

The railtie integrates dry-system with the Rails runtime by setting up a system container for you that works out of the box with no configuration required. This is based on a couple of conventions:

1. The system container is defined as `Container` constant within your application namespace defined by `config/application.rb`. For example, if you generate a new rails application and call it `blog`, then the application namespace will be called `Blog`, and so your system container will be available as `Blog::Container`
2. The auto-injection mixin is defined as `Deps` under the application namespace too
3. You can tweak the system container via an initializer, it can be called however you want, but the convention that we use is to call it `config/initializers/system.rb`
4. Bootable components are expected to be found in `config/system/*.rb` files

The railtie supports code-reloading in development mode - `Container`, `Deps` and boot files get reloaded upon every request (or when you manually `reload!` in the console).

## Using auto-registration

Currently, the railtie **does not make any assumptions about your directory/file structure**. This means you are expected to specify where your components are located. Here's an example:

```ruby
# config/initializers/system.rb
Dry::Rails.container do
  config.component_dirs.add "app/operations"
  config.component_dirs.add "lib" do |dir|
    dir.namespaces.add "my_super_cool_app", key: nil
  end
end
```

Then, in `app/operations` you can add your own classes and have them auto-registered and exposed via application container:

```ruby
# app/operations/users/create
module Users
  class Create
  end
end
```

You can easily verify this using the console:

```ruby
irb(main):001:0> MyApp::Container['users.create']
=> #<Users::Create:0x00007fa8f7c04f48>
```

### Using `Deps` mixin

The auto-injection mechanism is also set up for you automatically. Let's say you have a GitHub service that needs an HTTP client. The HTTP client will be part of your `lib` but the GitHub service will be part of your `app`. Here's how you could set it up:

```ruby
# lib/my_app/http.rb
module MyApp
  class HTTP
    # some useful methods
  end
end

# app/services/github.rb
class Github
  include MyApp::Deps[:http]

  # more useful methods
end
```

You can verify that `Github` has access to `HTTP` object in the console:

```ruby
# bin/rails console

irb(main):001:0> MyApp::Container[:github]
=> #<Github:0x00007fb38c2fae30 @http=#<MyApp::HTTP:0x00007fb38c2fb150>>
```

## Inflector

By default, the railtie registers `ActiveSupport::Inflector` as the default inflector. You can access it via container:

```ruby
# bin/rails console

irb(main):007:0> MyApp::Container[:inflector].demodulize("MyApp::Container")
=> "Container"
```

^INFO
It is *recommended* to inject the inflector via the import module, instead of referring to the global `ActiveSupport::Inflector` constant. Otherwise you'll lose the ability to easily switch inflectors when you have a need, which *can happen*. Your future-self will be grateful.
^

## Safe Params

Controllers can specify schemas for their actions and access safe params through `safe_params` helper. This is like `strong_parameters` but much more powerful as its powered by dry-schema.

Here's a simple example:

```ruby
class UsersController < ApplicationController
  schema(:show, :edit) do
    required(:id).value(:integer)
  end

  before_action :set_user, only: %i[show edit]

  def show
    render :show, user: @user
  end

  def edit
    render :edit, user: @user
  end

  private

  def set_user
    @user = User.find(safe_params[:id])
  end
end
```

`safe_params` returns a dry-schema result object, you can use it to return a default error response, ie:

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do
    if safe_params && safe_params.failure?
      render(:error, errors: safe_params.errors.to_h)
    end
  end
end
```

## ApplicationContract

The railtie gives you access to `ApplicationContract` class which is powered by dry-validation. You can define your own contract classes and simply inherit from `ApplicationContract`:

```ruby
# lib/users/contracts/new.rb
module Users
  module Contracts
    class New < ApplicationContract
      # define the schema and rules
    end
  end
end
```

## Controller Helpers

With `:controller_helpers` feature you get a couple of convenient methods that makes it easier to access container and its registered objects:

- `ApplicationController#container` - a simple shortcut to `YourApp::Container` constant
- `ApplicationController#resolve` - a shortcut that delegates `resolve` to the container

Here's a simple usage example how you could access an operation powered by dry-monads:

```ruby
class UsersController < ApplicationController
  def create
    resolve("users.create").(safe_params[:user]) do |m|
      m.success do |user|
        render json: user
      end

      m.failure do |code, errors|
        render json: { code: code, errors: errors.to_h }, status: :unprocessable_entity
      end
    end
  end
end
```

^INFO
The railtie will soon provide monadic operations too!
^

## Turning features on/off

By default all the features are enabled but you can cherry-pick them if you want. Let's say you only want to use `safe_params` and `controller_helpers`, in such case you can configure that in the initializer:

```ruby
# config/initializers/system.rb
Dry::Rails.container do
  config.features = %i[
    safe_params
    controller_helpers
  ]
end
```

## Learn more

The railtie simply puts together other dry-rb gems and make them work out-of-the-box in a typical Rails application. If you want to fully leverage the power of these tools, it is recommended to check out individual gem documentation pages:

* [dry-system](/gems/dry-system) - which is the backbone of `Dry::Rails::Container`, your application container
* [dry-schema](/gems/dry-schema) - which gives you the safe params feature
* [dry-validation](/gems/dry-validation) - which gives you the application contract feature
