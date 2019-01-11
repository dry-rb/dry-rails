begin
  require 'byebug'
rescue LoadError; end

require 'dry-system-rails'

SPEC_ROOT = Pathname(__dir__)

Dir[SPEC_ROOT.join('shared/**/*.rb')].each(&method(:require))
Dir[SPEC_ROOT.join('support/**/*.rb')].each(&method(:require))

ENV['RAILS_ENV'] ||= 'test'
require SPEC_ROOT.join('dummy/config/environment')

RSpec.configure do |config|
  config.disable_monkey_patching!
end
