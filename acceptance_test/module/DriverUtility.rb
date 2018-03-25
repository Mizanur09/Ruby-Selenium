require 'active_support/time'
require 'rubygems'
require "json"
require 'selenium-webdriver'

module DriverUtility
  FIREFOX_PROFILE_PATH = File.expand_path('.') + "/acceptance_test/selenium-ruby/firefoxProfile"

  $DEMO = "https://provide the URL of Demo environment"
  $LOCAL ="https://provide the URL of Local environment"
  $REMOTE = "https://provide the URL of Remote environment"



  def initializeConfigurations(base_url = $LOCAL) # change the environment according to where the test need to be run. Example if you like to run into remote environment then base_url = $Remote
    if base_url == $REMOTE
      browserCapabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
      @driver = Selenium::WebDriver.for(:remote,
                                        url: "http://localhost:4444/wd/hub",
                                        desired_capabilities: browserCapabilities)
    elsif base_url == $LOCAL

      # Selenium::WebDriver::Chrome.driver_path='path of the chrome.exe'
      # @driver = Selenium::WebDriver.for :chrome
      # @driver = Selenium::WebDriver.for :safari

      @driver = Selenium::WebDriver.for :firefox
    end
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.window.maximize
    @verification_errors = []
    @driver.get(base_url)
  end

  def quitDriver()
    @driver.quit
    expect(@verification_errors).to eq([])
  end
 end


