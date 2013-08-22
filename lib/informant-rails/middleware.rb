module InformantRails
  class Middleware < Struct.new(:app)
    def call(env)
      InformantRails::Client.record(env)
      response = app.call(env)
      InformantRails::Client.process
      response
    end
  end
end
