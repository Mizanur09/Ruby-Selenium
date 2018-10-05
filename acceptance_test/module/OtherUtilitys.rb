require_relative '../Helpers_pages/globalized'
include Globalized

module OtherUtilitys

  # Add the attach file path
  # Add the attach file name
  def addAttachment(fieldName, value)
    inputFile = findElement(fieldName)
    inputFile.send_keys (File.dirname(__FILE__) + "/../resources/" + value)
  end

# DELETE attachment
  def deleteAttachment(element,attachementNumber)
    attachmentDeleteButtons = findElement(:css, element + "($index)")
    attachmentDeleteButtons[attachementNumber - 1].click
  end

end
