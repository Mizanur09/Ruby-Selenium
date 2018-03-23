require 'active_support/time'
require 'rubygems'
require "json"
require 'selenium-webdriver'

module DriverUtility
  FIREFOX_PROFILE_PATH = File.expand_path('.') + "/acceptance_test/selenium-ruby/firefoxProfile"

  def initializeConfigurations(base_url)

    # Selenium::WebDriver::Chrome.driver_path='path of the chrome.exe'
    # @driver = Selenium::WebDriver.for :chrome
    # @driver = Selenium::WebDriver.for :safari

    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.window.maximize
    @driver.manage.delete_all_cookies
    @driver.get(base_url + "/")
    @accept_next_alert = true
    @verification_errors = []
    end
  
  def quitDriver()
    @driver.quit
    expect(@verification_errors).to eq([])
  end
 end


