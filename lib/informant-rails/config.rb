module InformantRails::Config
  extend self

  attr_accessor :api_token, :exclude_models, :filter_parameters, :value_tracking

  self.api_token
  self.exclude_models = []
  self.filter_parameters = []
  self.value_tracking = true

  def configure; yield self end

  def self.client_identifier
    @client_identifier ||= "informant-rails-#{InformantRails::VERSION}"
  end

  def self.enabled?
    api_token.present?
  end

  def self.collector_host
    @collector_host ||= ENV['INFORMANT_COLLECTOR_HOST'] || 'https://collector-api.informantapp.com'
  end
end
