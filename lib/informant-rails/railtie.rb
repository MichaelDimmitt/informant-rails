module InformantRails
  class Railtie < ::Rails::Railtie
    initializer 'informant' do |config|
      Config.api_token ||= ENV['INFORMANT_API_KEY']

      if Config.enabled?
        config.middleware.use InformantRails::Middleware

        InformantRails::Config.filter_parameters = Rails.configuration.filter_parameters

        ActiveSupport.on_load(:action_controller) do
          include InformantRails::RequestTracking
        end

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
