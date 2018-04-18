require_relative '../Helpers_pages/globalized'
include Globalized

module WAIT_FUNCTION

# wait until the element is present
  def waitForElementPresent(how, what, waitTime = THE_TIMES)
    sleep 1
    puts waitTime
    if isElementPresent?(how, what)
      return true
    else
      raise Selenium::WebDriver::Error::NoSuchElementError
    end
    sleep 1
  end

  # wait until the page loading is done. as soon as page title present it will stop.
  def waitForPageToLoad(title, what='title')
    puts "waitForPageToLoad:('#{title}',#{what})"
    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => THE_TIMEOUT)
      wait.until {@driver.title}
      puts "waitForPageToLoad until reached title element with text set to [#{@driver.title}]"
    rescue Exception => e
      puts "waitForPageToLoad exception [#{e}]"
      return
    end
    waitForElementPresent(:css, what)
    iter = 0
    found = false
    THE_TIMES.times do
      puts "waitForPageToLoad: iter=[#{iter}] waiting for-->[#{title}] currently-->[#{@driver.find_element(:css, what).text}] "
      iter += 1
      if @driver.find_element(:css, what).text == title
        found = true
        break
      end
      sleep 1.0
    end
    if found then
      puts "waitForPageToLoad: After [#{iter}] tries: found expected text=[#{title}] in [#{what}] element"
    else
      puts "----TEST FAILED:---waitForPageToLoad: After [#{iter}] tries: NOT FOUND expected text=[#{title}] in [#{what}] element"
    end
    found.should == true
  end
  
  def wait_for_element_to_load(locator)
    sleep 1
    puts "Waiting for this locator to be visible on the page: #{locator}"
    if isElementVisible(locator)
      return true
    else
      raise Selenium::WebDriver::Error::NoSuchElementError
    end
    sleep 1
  end

  ## the following methods work when Loading Spinner present in the website.
  def waitForLoader
    element = @driver.find_element(:css, 'html')
    45.times {
      if !element.attribute('css').include?('.ui-loading') # provide the loader class
        return
      else
        sleep 1
      end
    }
    raise 'Loading Spinner Timeout'
  end









end