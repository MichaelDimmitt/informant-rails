module InformantRails
  class FieldError < Struct.new(:name, :value, :message)
  end
end
