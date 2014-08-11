require 'typhoeus'

module InformantRails
  class Client

    def self.record(env)
      unless env['REQUEST_METHOD'] == 'GET'
        new_request.request_url = env['HTTP_REFERER']
      end
    end

    def self.record_action(controller_name, action)
      if request
        request.filename = controller_name
        request.action = action
      end
    end

    def self.record_validated_model(model)
      request.process_model(model) if request && include_model?(model)
    end

    def self.process
      if request && request.models.any?
        Typhoeus::Request.new(
          api_url,
          method: :post,
          body: { payload: request }.to_json,
          headers: {
            "Authorization" => ActionController::HttpAuthentication::Token.encode_credentials(InformantRails::Config.api_token),
            "Content-Type" => "application/json"
          }
        ).run
      end
    ensure
      cleanup
    end

    def self.request
      Thread.current[:informant_request]
    end

    def self.cleanup
      Thread.current[:informant_request] = nil
    end

    private

    def self.include_model?(model)
      !InformantRails::Config.exclude_models.include?(model.class.to_s)
    end

    def self.new_request
      Thread.current[:informant_request] = Request.new
    end

    def self.api_url
      @api_url ||= 'https://api.informantapp.com/api/v1/form_submissions'
    end

  end
end
