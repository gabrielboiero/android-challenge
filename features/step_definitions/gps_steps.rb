Given(/^Set virtual GPS on "([^"]*)" with coordinates "([^"]*)" and "([^"]*)"$/) do |location, latitude, longitude|
  Genymotion::GPS.set_latitude(latitude)
  @fixed_lat = latitude

  Genymotion::GPS.set_longitude(longitude)
  @fixed_lng = longitude
end


When(/^Query values from Geolocation$/) do
  Geolocation.update_position
  @app_geo = Geolocation.values
end


Then(/^It should retrieve same pre\-fixed coordinates$/) do
  # Use a delta=0.001 because Genymotion rounds some values
  expect(@app_geo[:latitude].to_f).to be_within(0.001).of(@fixed_lat.to_f)
  expect(@app_geo[:longitude].to_f).to be_within(0.001).of(@fixed_lng.to_f)
end


When(/^Update position (\d+) times$/) do |num|
  num.to_i.times { Geolocation.update_position }
end


When(/^The GPS sensor is set to disabled$/) do
  Genymotion::GPS.disable
end


When(/^The GPS sensor is set to enabled$/) do
  Genymotion::GPS.enable
end


When(/^Battery power is set low$/) do
  Genymotion::Battery.set_charge(2)  # Set Battery to 2% of charge level
end


Then(/^It should retrieve zero values$/) do
  # NOTE:
  # This test should fail because 'update position' with GPS disabled
  # is not working properly from the application. Could be an issue
  # either from the application or from Genymotion emulator.

  Geolocation.update_position
  sleep(5) # With GPS disabled takes extra time to emulator to query values

  values = Geolocation.values
  expect(values[:latitude].to_f).to eql(0.0)
  expect(values[:longitude].to_f).to eql(0.0)
end
