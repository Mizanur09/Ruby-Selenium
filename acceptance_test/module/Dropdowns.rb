require_relative '../Helpers_pages/globalized'

module DropdownFunctions

# it will select the value using attribute(values)
  def getSelectedOptionValue(how, what)
    select = Selenium::WebDriver::Support::Select.new(@driver.find_element(how,  what))
    option = select.first_selected_option # ("first_selected_option" this methods is provided by ruby)
    return option.attribute('value')
  end

#Provide the Element here and then list of the value that you want to verify
#* expect(areAllTheseValuesAvailableInDropDown("Element", "Select,Normal,Abnormal")).to eq(true)
  def areAllTheseValuesAvailableInDropDown(cssPath, valueString)
    verifiedTrue = true
    select = findElement(:css, cssPath)
    options = select.find_elements(:tag_name, "option")
    options.each do |option|
      displayedValue = option.attribute('value')
      if displayedValue == nil then
        displayedValue = "Select"
      end
        if valueString.include?(displayedValue) == false then
          verifiedTrue = false
          break
        end
    end
      return verifiedTrue
  end

  # Collect all the dropdown value
  def getDownValues(fieldName)
    #puts "Type is [#{type}]"
    select = findElement(:css, "select[name='"+ fieldName + "']")
    options = select.find_elements(:tag_name, "option")
    values = []
    options.each_with_index do |e, i|
      #puts "Checking option <#{e.text}>"
      values << e.text
    end
    puts "getDownValues=[#{values}]" # will print all the array that has been collected so far.
    return values
  end

  # Return value text from the dropdown box.
  def getSelectBoxText(css_element)
    select = Selenium::WebDriver::Support::Select.new(@driver.find_element(:css,  css_element))
    return select.first_selected_option.text()
  end

  # Set drop down value by text.
  #* [pass the field element(css)
  #* Pass the desire value text(String)]
  def setSelectBoxValue(selector, value)
    field = findElement(:css, selector)
    if field != nil
      select = Selenium::WebDriver::Support::Select.new(field)
      @driver.execute_script("$('.container-fluid').css('overflow', 'auto');")
      select.select_by(:text, value)
      @driver.execute_script("$('.container-fluid').css('overflow', 'visible');")
      maximizeWindow
    end
  end





end