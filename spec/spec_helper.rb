require "bundler/setup"
require "tspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
