require_relative 'helper_page'

module DriverUtility
 
  $DEMO = 'https://provide the URL of Demo environment'
  $LOCAL ='https://provide the URL of Local environment'
  $REMOTE = 'https://provide the URL of Remote environment'
  SELENIUM_HUB = 'http://localhost:4444/wd/hub' 

  # $driver_path = '~//Users\M\Desktop\My Files\Apps/'
  $driver_path = 'Add the driver exe path'

########################################################################################################################
################################ REGULER BROWSERs ######################################################################
########################################################################################################################
  
  def start_FireFox
    # Add gecko driver when its selenium 3.0 ++
    @driver = Selenium::WebDriver.for :Firefox
  end

  def start_MicrosoftEge
    #edge_path = File.join(File.Absolute_path($driver_path, File.dirname(__FILE__)),"MicrosoftEdge", "Microsoft_Edge.exe")
    edge_path = File.join(File.Absolute_path($driver_path, File.dirname(__FILE__)),"Directory name", "DriverName.exe")
    Selenium::WebDriver::Edge.driver_path = edge_path
    @driver = Selenium::WebDriver.for :edge 
  end

  def start_IE
    IE_path = File.join(File.Absolute_path($driver_path, File.dirname(__FILE__)),"Directory_Name", "Driver_Name.exe")
    Selenium::WebDriver::IE.driver_path = IE_path
    @driver = Selenium::WebDriver.for :ie
  end

  def start_chrome
    chrome_path = File.join(File.Absolute_path($driver_path, File.dirname(__FILE__)),"Directory_Name", "Driver_Name.exe")
    Selenium::WebDriver::Chrome::Service.driver_path = chrome_path #Service must be added in order to lounch the chrome browser.
    @driver = Selenium::WebDriver.for Chrome
  end

  def start_safari
    # I will add Safari browser information very soon.     
  end

########################################################################################################################
###############REMOTE BROWSERs #########################################################################################
########################################################################################################################
  
  def start_remote_Firefox
    browserCapabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
      @driver = Selenium::WebDriver.for(:remote,
                                        url: SELENIUM_HUB,
                                        desired_capabilities: browserCapabilities)
  end

  def browserfinalization (base_url)
    @driver.manage.window.maximize
    @driver.manage.timeouts.page_load = 15
    @driver.manage.timeouts.implicit_wait = 15
    @driver.manage.delete_all_cookies
    @driver.get(base_url)
    @accept_next_alert = true
    @verification_errors = []
  end

  def initializeConfigurations(base_url = $LOCAL) # change the environment according to where the test need to be run. Example if you like to run into remote environment then base_url = $Remote
    if base_url == $REMOTE
      start_remote_Firefox
    elsif base_url == $LOCAL
      start_chrome
    end
      browserfinalization
  end

  def quitDriver()
    @driver.quit
  end

 end


