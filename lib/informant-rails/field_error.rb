module InformantRails
  class FieldError
    attr_accessor :name, :value, :message

    def initialize(name, value, message=nil)
      self.name = name
      self.value = value
      self.message = message
    end

    def value=(value)
      @value = InformantRails::ParameterFilter.filter(name, value)
    end

    def as_json(*args)
      { name: name, value: value, message: message }
    end
  end
end
