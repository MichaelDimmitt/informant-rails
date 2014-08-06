module InformantRails
  module ValidationTracking
    extend ActiveSupport::Concern

    included do
      set_callback(:validate, :after) do
        InformantRails::Client.record_validated_model(self)
      end
    end
  end
end
