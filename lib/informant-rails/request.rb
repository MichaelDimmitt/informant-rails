module InformantRails
  class Request
    attr_accessor :request_url, :filename, :action

    def process_model(model)
      models << InformantRails::Model.new(model) if model
    end

    def models
      @models ||= []
    end

    def as_json(*args)
      {
        models: models.map(&:as_json),
        request_url: request_url,
        filename: filename,
        action: action
      }
    end
  end
end
