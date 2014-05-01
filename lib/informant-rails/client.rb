require 'typhoeus'

module InformantRails
  class Client
    @requests = {}

    def self.record(env)
      unless env['REQUEST_METHOD'] == 'GET'
        new_request.request_url = env['HTTP_REFERER']
      end
    end

    def self.inform_action(controller_name, action)
      if request
        request.filename = controller_name
        request.action = action
      end
    end

    def self.inform(model)
      request.process_model(model) if request && include_model?(model)
    end

    def self.process
      if Config.api_token.present? && request && request.models.any?
        Typhoeus::Request.new(
          api_url,
          method: :post,
          params: { payload: request.as_json },
          headers: { Authorization: ActionController::HttpAuthentication::Token.encode_credentials(InformantRails::Config.api_token) }
        ).run
      end
    ensure
      remove_request
    end

    def self.request
      @requests[request_id]
    end

    private

    def self.include_model?(model)
      !InformantRails::Config.exclude_models.include?(model.class.to_s)
    end

    def self.new_request
      @requests[request_id] = Request.new
    end

    def self.remove_request
      @requests.delete(request_id)
    end

    def self.request_id
      Thread.current.object_id
    end

    def self.api_url
      @api_url ||= ['http://api.informantapp.com/api/v1', InformantRails::Config.server_environment].join('/')
    end
  end
end
