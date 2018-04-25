require 'active_support/time'
require 'rubygems'
require "json"
require 'selenium-webdriver'

module DriverUtility
  FIREFOX_PROFILE_PATH = File.expand_path('.') + '/acceptance_test/selenium-ruby/firefoxProfile'

  $DEMO = 'https://provide the URL of Demo environment'
  $LOCAL ='https://provide the URL of Local environment'
  $REMOTE = 'https://provide the URL of Remote environment'



  def initializeConfigurations(base_url = $LOCAL) # change the environment according to where the test need to be run. Example if you like to run into remote environment then base_url = $Remote
    if base_url == $REMOTE
      browserCapabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
      @driver = Selenium::WebDriver.for(:remote,
                                        url: 'http://localhost:4444/wd/hub',
                                        desired_capabilities: browserCapabilities)
    elsif base_url == $LOCAL

      # Selenium::WebDriver::Chrome.driver_path='path of the chrome.exe'
      # @driver = Selenium::WebDriver.for :chrome
      # @driver = Selenium::WebDriver.for :safari
    end
    profile = Selenium::WebDriver::Firefox::Profile.new(@FIREFOX_PROFILE_PATH)
    profile['browser.cache.disk.enable'] = false
    profile['browser.cache.memory.enable'] = false
    profile['browser.cache.offline.enable'] = false
    profile['network.http.use-cache'] = false

    @driver = Selenium::WebDriver.for :firefox, :profile => profile
    @driver.manage.window.maximize
    @driver.manage.timeouts.page_load = IMPLICIT_WAIT_FOR_WEB_ELEMENT_DEFAULT
    @driver.manage.timeouts.implicit_wait = IMPLICIT_WAIT_FOR_WEB_ELEMENT_DEFAULT
    @driver.manage.delete_all_cookies
    @driver.get(base_url)
    @accept_next_alert = true
    @verification_errors = []
  end

  def quitDriver()
    @driver.quit
  end

 end


