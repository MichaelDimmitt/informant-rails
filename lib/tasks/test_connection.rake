namespace :informant do

  desc "Sends a sample request from your server to Informant"
  task :test_connection => :environment do
    InformantRails::ConnectionTester.run
  end

end
