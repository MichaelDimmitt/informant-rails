module InformantRails
  class Client
    @requests = {}

    def self.record(env)
      new_request.request_url = env['HTTP_REFERER']
    end

    def self.request
      @requests[Thread.current.object_id]
    end

    private

    def self.new_request
      @requests[Thread.current.object_id] = Request.new
    end
  end
end
