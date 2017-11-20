if CAPABILITIES[:mongoid]
  if Mongoid.respond_to?(:load_configuration)
    Mongoid.load_configuration({
      # mongoid >= 5
      clients: {
        default: {
          database: 'informant_rails_test',
          hosts: [ 'localhost:27017' ]
        }
      },

      # mongoid <= 4.x
      sessions: {
        default: {
          database: 'informant_rails_test',
          hosts: [ 'localhost:27017' ]
        }
      }
    })
  else
    # momgoid 3.0
    Mongoid.load!("spec/support/mongoid.yml", :test)
  end

  def clear_mongodb
    Mongoid::Config.purge!
  end

  class User
    include Mongoid::Document
    include InformantRails::ValidationTracking

    validates_presence_of :email
    validates_length_of :name, minimum: 2

    validate :base_error

    field :name
    field :email

    attr_accessor :add_base_error

    def base_error
      errors[:base] << 'This is a base error' if add_base_error
    end
  end
end
