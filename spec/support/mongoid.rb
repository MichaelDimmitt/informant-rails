if defined?(Mongoid)
  Mongoid.load!("spec/support/mongoid.yml", :test)

  def clear_mongodb
    Mongoid::Config.purge!
  end

  class User
    include Mongoid::Document
    include InformantRails::ValidationTracking

    validates_presence_of :email
    validates_length_of :name, minimum: 2

    field :name
    field :email
  end
end
