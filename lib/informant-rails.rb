require 'informant-rails/railtie'

module InformantRails
  autoload :Config,     'informant-rails/config'
  autoload :Client,     'informant-rails/client'
  autoload :FieldError, 'informant-rails/field_error'
  autoload :Middleware, 'informant-rails/middleware'
  autoload :Model,      'informant-rails/model'
  autoload :Request,    'informant-rails/request'
end
