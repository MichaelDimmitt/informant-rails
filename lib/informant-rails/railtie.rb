module InformantRails
  class Railtie < ::Rails::Railtie
    initializer 'informant middleware' do |config|
      config.middleware.use 'InformantRails::Middleware'
    end

    initializer 'informant ActionController binding' do
      class ::ActionController::Base
        before_filter do
          InformantRails::Client.record_action(
            controller_name, action_name
          )
        end
      end

      InformantRails::Config.filter_parameters = Rails.configuration.filter_parameters
    end

    initializer 'informant ActiveRecord binding' do
      class ::ActiveRecord::Base
        set_callback(:validate, :after) do
          InformantRails::Client.record_validated_model(self)
        end
      end
    end
  end
end
