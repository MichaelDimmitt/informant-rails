class TestApp < Rails::Application
  config.eager_load = false
  config.root = "#{File.dirname(__FILE__)}/.."
end
Rails.env = 'test'
Rails.application = TestApp
TestApp.initialize!
I18n.enforce_available_locales = true
Rails.application.config.active_support.deprecation = :stderr
