require 'bundler'

require 'rails/all'

Bundler.require(:default, :gemspec)

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) { TestMigration.up }
end
