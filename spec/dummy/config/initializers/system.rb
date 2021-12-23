# frozen_string_literal: true

require "dry/rails"

Dry::Rails.container do
  config.component_dirs.add "lib" do |dir|
    dir.default_namespace = "dummy"
  end

  config.component_dirs.add "app/operations"
  config.component_dirs.add "app/services"
  config.component_dirs.add("app/workers") do |dir|
    dir.memoize = true
  end
end
