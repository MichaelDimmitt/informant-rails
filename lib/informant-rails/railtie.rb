module InformantRails
  class Railtie < ::Rails::Railtie
    initializer 'informant middleware' do |config|
      if InformantRails::Config.api_token
        config.middleware.use 'InformantRails::Middleware'
      end
    end

    initializer 'informant ActionController binding' do
      if InformantRails::Config.api_token
        class ::ActionController::Base
          before_filter do
            InformantRails::Client.record_action(controller_name, action_name)
          end
        end

        InformantRails::Config.filter_parameters = Rails.configuration.filter_parameters
      end
    end

    initializer 'informant ActiveRecord binding' do
      if InformantRails::Config.api_token

        ActiveSupport.on_load(:active_record) do
          include InformantRails::ValidationTracking
        end

        ActiveSupport.on_load(:mongoid) do
          include InformantRails::ValidationTracking
        end

      end
    end
  end
end
