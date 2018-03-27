require_relative '../Helpers_pages/globalized'
include Globalized


module Functions

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

  def waitForPageToLoad(title, what='title') # 'navbar-brand')
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
      if @driver.find_element(:css, what).text == title # @driver.find_element(:class, what).text == title
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

  def isElementPresent?(how, what)
    begin
      element = @driver.find_element(how, what)
      return element.displayed?
    rescue Exception => e
      return false
    end
  end

  def verify_text_is_visible(locator, text)
    wait_for_element_to_load(locator)
    puts "Verifying this text: #{text} does display for this locator: #{locator} "
    element = find(locator)
    return element.text.strip.should == text
  end

  def verify_text_is_not_visible(locator, text)
    puts "Verifying this text: #{text} does not display for this locator: #{locator}"
    element = find(locator)
    return element.text.strip.should_not == text
  end

  def verify_element_is_visible(locator)
    begin
      puts "Verifying this locator: #{locator} does display"
      find(locator).displayed?.should == true
      return true
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      return true.should == false
    end
  end

  def verify_element_is_not_visible(locator)
    begin
      puts "Verifying this locator: #{locator} does not display"
      find(locator).displayed?.should == false
      return true
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      return true.should == true
    end
  end

  def executeJquery(jqueryStr)
    @driver.execute_script(jQuery(jqueryStr))
  end

  def scrollIntoElement(elementId)
    s = "document.getElementById('#{elementId}').scrollIntoView(true);"
    @driver.execute_script(s)
  end


end