---
title: Introduction
description: The dry-rb railtie
layout: gem-single
order: 7
type: gem
name: dry-rails
---

## Installation

To generate a new application skeleton with `dry-rails` installed, you can use the default template
provided by the gem. Here's a minimalistic example:

```bash
rails new my_app -MOPCSJT --template https://raw.githubusercontent.com/dry-rb/dry-rails/master/templates/default.rb
```

If you already have a Rails application, simply add `dry-rails` to your `Gemfile`:

```ruby
gem "dry-rails", "~> 0.1"
```

## Using auto-registration

You can configure the application container to load files and register objects automatically via
`auto_register!` feature. Typically, you want to set this up in the system initializer:

```ruby
# config/initializers/system.rb
Dry::Rails.container do
  auto_register!("app/operations")
end
```

Then, in `app/operations` you can add your own classes and have them auto-registered and exposed via
application container:

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

## ApplicationContract

The railtie gives you access to `ApplicationContract` class which is powered by dry-validation. You
can define your own contract classes and simply inherit from `ApplicationContract`:

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

to be continued...
