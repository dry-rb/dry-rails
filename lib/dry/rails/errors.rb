# frozen_string_literal: true

module Dry
  module Rails
    InvalidAutoRegistrarStrategy = Class.new(StandardError) do
      def initialize(name, valid_names)
        super(<<~STR)
          AutoRegistrar strategy #{name} is not valid.
          Possible options are: #{valid_names.inspect}
        STR
      end
    end
  end
end
