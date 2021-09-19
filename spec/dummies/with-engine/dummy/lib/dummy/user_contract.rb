# frozen_string_literal: true

module Dummy
  class UserContract < ApplicationContract
    params do
      required(:name).filled(:string)
    end
  end
end
