module InformantRails
  class Model < Struct.new(:model)
    def name
      model.class.name
    end

    def errors
      model.errors.map do |field, error|
        InformantRails::FieldError.new(field.to_s, model[field], error)
      end
    end

    def as_json(*args)
      { name: name, errors: errors.map(&:as_json) }
    end
  end
end
