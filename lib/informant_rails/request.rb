module InformantRails
  class Request
    attr_accessor :request_url

    def process_model(model)
      models << InformantRails::Model.new(model) if model
    end

    def models
      @models ||= []
    end
  end
end
