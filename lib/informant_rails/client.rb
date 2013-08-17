module InformantRails
  class Client
    @requests = {}

    def self.record(env)
      new_request.request_url = env['HTTP_REFERER']
    end

    def self.inform(model)
      request.process_model(model) if request && model
    end

    def self.process
      Typhoeus.post(
        api_url, body: request.to_json
      ) if Config.api_token.present?
      remove_request
    end

    def self.request
      @requests[Thread.current.object_id]
    end

    private

    def self.new_request
      @requests[Thread.current.object_id] = Request.new
    end

    def self.remove_request
      @requests.delete(Thread.current.object_id)
    end

    def self.api_url
      @api_url ||= [
        'http://informant-production.herokuapp.com/v1',
        Config.api_token,
        Config.server_environment
      ].join('/')
    end
  end
end
