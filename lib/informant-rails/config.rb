module InformantRails::Config
  extend self

  attr_accessor :api_token, :server_environment

  @api_token = ENV['INFORMANT_API_KEY']
  @server_environment = Rails.env

  def configure; yield self end
end
