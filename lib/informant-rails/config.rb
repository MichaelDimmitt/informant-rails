module InformantRails::Config
  extend self

  attr_accessor :api_token, :server_environment, :exclude_models

  self.api_token = ENV['INFORMANT_API_KEY']
  self.server_environment = Rails.env
  self.exclude_models = []

  def configure; yield self end
end
