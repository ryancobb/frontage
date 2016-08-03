require 'rubygems'
require 'bundler/setup'
require 'capybara/rspec'
require 'capybara/poltergeist'

Bundler.require(:default)

###################### Rspec config ############################
RSpec.configure do |config|
  config.color = true
  config.failure_exit_code = 0
end

################ Default Environment ##########################
ENV["env"] ? ENV["env"] : ENV["env"] = "qa"
###############################################################

################### Driver Setup ##############################
Capybara.default_driver = :selenium_chrome
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true)
end

case ENV["browser"]
when "firefox"
  Capybara.default_driver = :selenium
when "webkit"
  Capybara.default_driver = :webkit
when "poltergeist"
  Capybara.default_driver = :poltergeist
when "poltergeist_debug"
  Capybara.default_driver = :poltergeist_debug
else
  ENV["browser"] = "chrome"
  Capybara.default_driver = :selenium_chrome
end

puts "Running tests in #{ENV["env"]} with #{ENV["browser"]}"
###############################################################
