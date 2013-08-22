module InformantRails
  class Model
    attr_accessor :name, :errors

    def initialize(model)
      self.name = model.class.name
      self.errors = model.errors.map do |field, error|
        InformantRails::FieldError.new(field.to_s, model[field], error)
      end
    end
  end
end
