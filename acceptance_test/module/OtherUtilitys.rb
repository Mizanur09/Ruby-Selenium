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

    @today = getDateNthDaysAgo(0, "%m/%d/%Y")
    @tomorrow = getDateNthDaysFromNow(1, "%m/%d/%Y")
    @fifteenDaysAgo = getDateNthDaysAgo(15, "%m/%d/%Y")

    @oneDayAgo = getDateNthDaysAgo(1, "%m/%d/%Y")
    @twoDaysAgo = getDateNthDaysAgo(2, "%m/%d/%Y")

    @thirtyDaysAgo = getDateNthDaysAgo(30, "%m/%d/%Y")
    @fortyDaysAgo = getDateNthDaysAgo(40, "%m/%d/%Y")
    @fiftyDaysAgo = getDateNthDaysAgo(40, "%m/%d/%Y")

    @twentynineDaysAgo = getDateNthDaysAgo(29, "%m/%d/%Y")
    @twentysevenDaysAgo = getDateNthDaysAgo(27, "%m/%d/%Y")
    @twentyfiveDaysAgo = getDateNthDaysAgo(25, "%m/%d/%Y")
    @twentyDaysAgo = getDateNthDaysAgo(20, "%m/%d/%Y")

  def getDateNthDaysAgo(numberOfDaysAgo, formatStr)
    dateNthDaysAgo = numberOfDaysAgo.day.ago.strftime(format=formatStr)
    return dateNthDaysAgo
  end

  def getDateNthDaysFromNow(numberOfDaysFromNow, formatStr)
    dateNthDaysFromNow = numberOfDaysFromNow.day.from_now.strftime(format=formatStr)

    return dateNthDaysFromNow
  end

end
