require 'bundler/setup'

Bundler.require(:default)

require 'informant-rails'
InformantRails::Config.api_token = 'abc123'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    if defined?(ActiveRecord)
      TestMigration.up
    elsif defined?(Mongoid)
      clear_mongodb
    end

    InformantRails::Config.filter_parameters = [:password]
  end
end
