module Android

  DEFAULT_WAIT = 30

  @@driver = nil

  def driver
    new_driver if @@driver.nil?
    @@driver
  end

  def new_driver
    capabilities = {"aut" => "com.ionicframework.ionicchallengeapp873008:0.0.1"}
    @@driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities)
    set_implicit_wait(DEFAULT_WAIT)

    sleep(5)  # Forced sleep to allow apk finish loading
    set_hybrid_app
    sleep(10) # Forced sleep to avoid Net::ReadTimeout exception from selenium server
  end

  def reset_driver
    @@driver = nil
  end

  # set global wait to be accessible in any module/class
  # usage: wait(20).until{ driver.find_element(:id => "some-dynamic-element")}
  def wait(seconds)
    Selenium::WebDriver::Wait.new(:timeout => seconds)
  end

  def set_implicit_wait(seconds)
    @@driver.manage.timeouts.implicit_wait = seconds
  end


  def set_hybrid_app
    # For hybrid app (ionicframework) switch view to embedded webkit
    driver.switch_to.window('WEBVIEW')
  end

end
