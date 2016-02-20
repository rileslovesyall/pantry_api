ENV['RACK_ENV'] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../app.rb")


RSpec.configure do |config|

  # wrap each test in a transaction, so one doesn't mess up another one
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

end
