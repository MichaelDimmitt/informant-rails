module InformantRails
  class Model
    attr_accessor :name, :errors

    def initialize(model)
      self.name = model.class.name
      self.errors = model.errors.map do |field, error|
        InformantRails::FieldError.new(field.to_s, model[field], error)
      end
    end

    def as_json(*args)
      { name: name, errors: errors.map(&:as_json) }
    end
  end
end
