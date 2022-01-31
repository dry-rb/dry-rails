# frozen_string_literal: true

module Dummy
  class Notifier
    include Deps[:mailer]
  end
end
