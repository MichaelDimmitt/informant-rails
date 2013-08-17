require 'informant_rails/railtie'

module InformantRails
  autoload :Client, 'informant_rails/client'
  autoload :Middleware, 'informant_rails/middleware'
  autoload :Request, 'informant_rails/request'
end
