module InformantRails
  module RequestTracking
    extend ActiveSupport::Concern

    included do
      before_action do
        InformantRails::Client.record_action(controller_name, action_name)
      end
    end
  end
end
