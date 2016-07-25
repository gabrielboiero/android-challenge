require 'selenium-webdriver'
require 'pry'

require './features/support/settings.rb'
require './lib/elements/geolocation.rb'
require './lib/helpers/genymotion.rb'

include Selenium::WebDriver::DriverExtensions::HasInputDevices
include Selenium::WebDriver::DriverExtensions::HasTouchScreen
include Android


# Cucumber hooks

Before do |scenario|
  Genymotion::GPS.enable
  Genymotion::Battery.set_charge(100)
end

After do |scenario|
end

at_exit do
  driver.quit
  reset_driver
end
