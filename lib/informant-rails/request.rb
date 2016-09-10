module InformantRails
  class Request
    attr_accessor :request_url, :filename, :action

    def process_model(model)
      if model && untracked?(model)
        models << InformantRails::Model.new(model)
      end
    end

    def models
      @models ||= []
    end

    def as_json(*args)
      {
        models: models.map(&:as_json),
        request_url: request_url,
        filename: filename,
        action: action,
        client: InformantRails::Config.client_identifier,
        rails_version: rails_version
      }
    end

    protected

    def rails_version
      @rails_version ||= Rails.version
    end

    def untracked?(model)
      !models.detect { |container| container.model == model }
    end
  end
end
