module InformantRails
  class ConnectionTester
    def self.run; new.run end

    def run
      if InformantRails::Config.api_token.blank?
        Rails.logger.info missing_api_token_message
      else
        InformantRails::Client.record('HTTP_REFERER' => '/connectivity/test')
        InformantRails::Client.record_action('Connectivity', 'test')
        InformantRails::Client.request.instance_variable_set('@models', [{
          name: 'TestClass',
          errors: [name: 'field_name', value: 'field_value', message: 'must be unique']
        }])
        response = InformantRails::Client.process

        if response.success?
          Rails.logger.info success_message
        else
          Rails.logger.info bad_response_message(response.body)
        end
      end

      Rails.logger.info assistance_message
    end

    private

    def missing_api_token_message
      %<
        Your API token could not be found in the configuration. You can retrieve it from your Informantapp.com dashboard.

          Then add it to your server's environment as `INFORMANT_API_KEY`

          OR

          Set it manually with an initializer (config/informant.rb)
            InformantRails::Config.api_token = 'your token'
      >
    end

    def bad_response_message(server_message)
      "Seems like we have a problem. \"#{server_message}\" in this case."
    end

    def success_message
      "Everything looks good. You should see a test request on your dashboard."
    end

    def assistance_message
      "If you need assistance or have any questions, send an email to informantapp@gmail.com or tweet @informantapp and we'll help you out!"
    end
  end
end
