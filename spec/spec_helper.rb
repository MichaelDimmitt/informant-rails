require 'bundler/setup'

Bundler.require

CAPABILITIES = {
  active_record: defined?(ActiveRecord),
  mongoid: defined?(Mongoid)
}

ENV['INFORMANT_API_KEY'] = 'abc123'
require 'informant-rails'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

CAPABILITIES[:user_model] = defined?(User)

RSpec.configure do |config|
  config.before(:each) do
    if CAPABILITIES[:active_record]
      TestMigration.up
    end

    if CAPABILITIES[:mongoid]
      clear_mongodb
    end

    InformantRails::Config.filter_parameters = [:password]
    InformantRails::Client.cleanup
  end

  config.around do |example|
    example.run if CAPABILITIES.fetch(example.metadata[:depends_on], true)
  end
end
