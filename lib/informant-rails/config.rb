module InformantRails::Config
  extend self

  attr_accessor :api_token, :server_environment, :exclude_models, :filter_parameters

  self.api_token = ENV['INFORMANT_API_KEY']
  self.server_environment = Rails.env
  self.exclude_models = []
  self.filter_parameters = []

  def configure; yield self end
end
