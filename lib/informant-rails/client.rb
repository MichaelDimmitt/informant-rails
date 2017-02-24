require 'net/http'

module InformantRails
  class Client

    def self.record(env)
      new_request.request_url = env['HTTP_REFERER'] unless env['REQUEST_METHOD'] == 'GET'
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
        this_request = request
        Thread.new { transmit(this_request) }
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

    def self.transmit(completed_request)
      Net::HTTP.start(api_endpoint.host, api_endpoint.port, use_ssl: api_endpoint.scheme == 'https') do |http|
        http.request(net_http_post_request(completed_request))
      end
    end

    private

    def self.net_http_post_request(completed_request)
      Net::HTTP::Post.new(api_endpoint, {
        "Authorization" => ActionController::HttpAuthentication::Token.encode_credentials(Config.api_token),
        "Content-Type" => "application/json"
      }).tap { |r| r.body = { payload: completed_request }.to_json }
    end

    def self.include_model?(model)
      !Config.exclude_models.include?(model.class.to_s)
    end

    def self.new_request
      Thread.current[:informant_request] = Request.new
    end

    def self.api_endpoint
      @api_endpoint ||= URI("#{Config.collector_host}/api/v1/form_submissions")
    end

  end
end
