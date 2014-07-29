require 'informant-rails/railtie'

if defined?(Rake)
  require 'rake'
  Dir[File.join(File.dirname(__FILE__), 'tasks', '**/*.rake')].each { |rake| load rake }
end

module InformantRails
  autoload :Config,           'informant-rails/config'
  autoload :ConnectionTester, 'informant-rails/connection_tester'
  autoload :Client,           'informant-rails/client'
  autoload :FieldError,       'informant-rails/field_error'
  autoload :Middleware,       'informant-rails/middleware'
  autoload :Model,            'informant-rails/model'
  autoload :Request,          'informant-rails/request'
  autoload :ParameterFilter,  'informant-rails/parameter_filter'
  autoload :VERSION,          'informant-rails/version'
end
