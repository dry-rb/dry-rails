---
title: Introduction
description: The dry-rb railtie
layout: gem-single
order: 7
type: gem
name: dry-rails
---

^WARNING
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
gem "dry-rails", "~> 0.1"
```

## Using auto-registration

You can configure the application container to load files and register objects automatically via `auto_register!` feature. Typically, you want to set this up in the system initializer:

```ruby
# config/initializers/system.rb
Dry::Rails.container do
  auto_register!("app/operations")
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

`safe_params` returns a dry-schema result object, you can use it return a default error response, ie:

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do
    if safe_params && safe_params.failure?
      render :error, errors: safe_params.errors.to_h and return false
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
