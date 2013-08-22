module InformantRails
  class Railtie < ::Rails::Railtie
    initializer 'informant middleware' do |config|
      config.middleware.use 'InformantRails::Middleware'
    end

    initializer 'informant ActionController binding' do
      class ::ActionController::Base
        before_filter do
          InformantRails::Client.inform_action(
            controller_name, action_name
          )
        end
      end
    end

    initializer 'informant ActiveRecord binding' do
      class ::ActiveRecord::Base
        def valid?(*args)
          result = super(*args)
          InformantRails::Client.inform(self) if errors.any?
          result
        end
      end
    end
  end
end
