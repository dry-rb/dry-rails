# frozen_string_literal: true

require 'dry/system'

Dry::System.register_provider(
  :rails,
  boot_path: Pathname(__dir__).join('boot').realpath
)
