require_relative '../Helpers_pages/globalized'

module DropdownFunctions


  def getSelectedOptionValue(how, what)
    select = Selenium::WebDriver::Support::Select.new(@driver.find_element(how,  what))
    option = select.first_selected_option # ("first_selected_option" this methods is provided by ruby)
    return option.attribute('value')
  end







end