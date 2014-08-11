module InformantRails
  class Middleware < Struct.new(:app)
    def call(env)
      Client.record(env)
      response = app.call(env)
      Client.process
      response
    end
  end
end
