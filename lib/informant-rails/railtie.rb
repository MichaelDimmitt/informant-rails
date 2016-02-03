module InformantRails
  class Railtie < ::Rails::Railtie
    initializer 'informant middleware' do |config|
      config.middleware.use InformantRails::Middleware
    end

    initializer 'informant ActionController binding' do
      ActiveSupport.on_load :action_controller do
        include InformantRails::RequestTracking
      end

      InformantRails::Config.filter_parameters = Rails.configuration.filter_parameters
    end

    initializer 'informant ActiveRecord binding' do
      ActiveSupport.on_load(:active_record) do
        include InformantRails::ValidationTracking
      end

      ActiveSupport.on_load(:mongoid) do
        include InformantRails::ValidationTracking
      end
    end
  end
end
