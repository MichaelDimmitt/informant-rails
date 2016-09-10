module InformantRails
  module RequestTracking
    extend ActiveSupport::Concern

    included do
      if defined? before_action
        before_action do
          InformantRails::Client.record_action(controller_name, action_name)
        end
      else
        before_filter do
          InformantRails::Client.record_action(controller_name, action_name)
        end
      end
    end
  end
end
