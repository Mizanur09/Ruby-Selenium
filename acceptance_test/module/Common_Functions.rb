require_relative '../Helpers_pages/globalized'
include Globalized

module Functions

  def isElementPresent?(how, what)
    begin
      element = @driver.find_element(how, what)
      return element.displayed?
    rescue Exception => e
      return false
    end
  end

  def isElementVisible(locator)
    begin
      element = find(locator)
      return element.displayed?
    rescue Exception=>e
      return false
    end
  end

  def verify_text_is_visible(locator, text)
    wait_for_element_to_load(locator)
    puts "Verifying this text: #{text} does display for this locator: #{locator} "
    element = find(locator)
    return element.text.strip.should == text
  end

  # def verify_element_is_visible(locator)
  #   begin
  #     puts "Verifying this locator: #{locator} does display"
  #     find(locator).displayed?.should == true
  #     return true
  #   rescue Selenium::WebDriver::Error::NoSuchElementError => e
  #     return true.should == false
  #   end
  # end

  def verify_text_is_not_visible(locator, text)
    puts "Verifying this text: #{text} does not display for this locator: #{locator}"
    element = find(locator)
    return element.text.strip.should_not == text
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

  def removeJumpScreen
    @driver.execute_script("$('.container-fluid').css('overflow', 'visible');")
  end

  def findElement(how, what)
    element = @driver.find_element(how, what)
    return element
  end

  #It will pull out the element color
  def getElementColor(selector, cssvalue)
    rgb = findElement(:css, selector).css_value(cssvalue).gsub(/rgba\(/,"").gsub(/\)/,"").split(",")
    color = '#%02x%02x%02x' % [rgb[0], rgb[1], rgb[2]]
    return color.upcase
  end


end