require_relative '../Helpers_pages/globalized'

module DropdownFunctions


  def getSelectedOptionValue(how, what)
    select = Selenium::WebDriver::Support::Select.new(@driver.find_element(how,  what))
    option = select.first_selected_option # ("first_selected_option" this methods is provided by ruby)
    return option.attribute('value')
  end

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





end