# frozen_string_literal: true

module Workers
  class MailerWorker
    include Dummy::Import['mailer']
  end
end
