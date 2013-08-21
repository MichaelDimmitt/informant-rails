module InformantRails
  class Request
    attr_accessor :request_url, :file_name, :action

    def process_model(model)
      models << InformantRails::Model.new(model) if model
    end

    def models
      @models ||= []
    end
  end
end
