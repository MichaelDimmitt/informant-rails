require 'bundler/setup'

Bundler.require(:default)

require 'informant-rails'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    TestMigration.up
    InformantRails::Config.filter_parameters = [:password]
  end
end
