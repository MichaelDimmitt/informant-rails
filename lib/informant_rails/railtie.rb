module InformantRails
  class Railtie < ::Rails::Railtie
    initializer 'informant ActiveRecord binding' do
      class ::ActiveRecord::Base
        def valid?(*args)
          result = super(*args)
          InformantRails::Client.inform(self) if errors.any?
          result
        end
      end
    end
  end
end
