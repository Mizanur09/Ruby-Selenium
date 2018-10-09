require_relative '../Helpers_pages/globalized'
include Globalized

module DateSetup

##############################################   DATE  #############################################
  # Date set up
  @oneDayAgo = getDateNthDaysAgo(-1)
  @today = getDateNthDaysAgo(0)
  @tomorrow = getDateNthDaysFromNow(1)

  # Month set up
  @LastMonth = getDateNthMonthsAgo(-1)
  @CurrentMonth = getDateNthMonthsAgo(0)
  @NextMonth = getDateNthMonthsFromNow(1)

  # Year set up
  @LastYear = getDateNthYearsAgo(-1)
  CurrentYear = getDateNthYearsAgo(0)
  @NextYear = getDateNthYeasFromNow(1)

  def setDate(dateStr, cssPath)
    findElement(:css, cssPath).clear
    findElement(:css, cssPath).send_keys(dateStr)
  end

  # Verify the date format in from the field
  def isDateFormatValid?(dateStr)
    begin
      dateObj = DateTime.strptime(dateStr, format= "%m/%d/%Y")
      puts "[isDateFormatValid?] Date is " + dateObj.to_s
      return true
    rescue Exception=>e
      return false
    end
  end

  # DATE [days]
  def getDateNthDaysAgo(numberOfDaysAgo)
    # def getDateNthDaysAgo(numberOfDaysAgo, formatStr) [following comment out lines are 'old style']
    # dateNthDaysAgo = numberOfDaysAgo.day.ago.strftime(format=formatStr)
    dateNthDaysAgo = numberOfDaysAgo.day.ago.strftime(format= "%m/%d/%Y")
    return dateNthDaysAgo
  end

  def getDateNthDaysFromNow(numberOfDaysFromNow)
    dateNthDaysFromNow = numberOfDaysFromNow.day.from_now.strftime(format= "%m/%d/%Y")
    return dateNthDaysFromNow
  end

  # DATE [months]
  def getDateNthMonthsAgo(numberOfDaysAgo)
  dateNthDaysAgo = numberOfDaysAgo.month.ago.strftime(format= "%m/%d/%Y")
  return dateNthDaysAgo
  end

  def getDateNthMonthsFromNow(numberOfDaysFromNow)
    dateNthDaysFromNow = numberOfDaysFromNow.month.from_now.strftime(format= "%m/%d/%Y")
    return dateNthDaysFromNow
  end


  # DATE [Years]
  def getDateNthYearsAgo(numberOfDaysAgo)
    dateNthDaysAgo = numberOfDaysAgo.year.ago.strftime(format= "%m/%d/%Y")
    return dateNthDaysAgo
  end

  def getDateNthYeasFromNow(numberOfYearsFromNow)
    dateStr = numberOfYearsFromNow.year.from_now.strftime(format= "%m/%d/%Y")
    return dateStr
  end

##############################################   TIME  #############################################

  def setTime( cssPath, timeStr)
    # Provide the time on the timeStr and add the Css path
    time = Time.parse(timeStr);
    findElement(:css,cssPath).send_keys(time.strftime("%I"))
    sleep 0.5
    findElement(:css,cssPath).send_keys [:shift, ";"]
    findElement(:css,cssPath).send_keys(time.strftime("%M %p"))
  end

# Verify the date format in from the field
# * expect(isTimeFormatValid?("01:03 PM")).to eq(true)
  def isTimeFormatValid?(timeStr)
    begin
      time = DateTime.strptime(timeStr, format= "%I:%M %p")
      puts "[isTimeFormatValid?] Time is " + time.to_s
      return true
    rescue Exception=>e
      return false
    end
  end

  # Change the time Using Java script
  def selectTimeZone(timeZone)
    puts "Time Zone is " + timeZone
    selectTimeZone("(-05:00) America/New_York (Eastern)")
    Sleep 1
    @driver.execute_script("$('[name=timeZone]').scope().preferences.timeZone = \"" + timeZone + "\"")
    @driver.execute_script("$('[name=timeZone]').scope().$digest()")
  end

  # Get local time.
  def getTodayInZeroTime
    a = Time.now.to_a
    a[0] = 0
    a[1] = 0
    a[2] = 0
    return Time.local(*a)
  end
  # Get UTC time
  def getTodayInZeroTimeUTC
    # Get current time into array
    # format is [sec,min,hour,day,month,year,wday,yday,isdst,zone]
    a = Time.now.utc.to_a
    # Zero out sec, min, hrs positions
    a[0] = 0
    a[1] = 0
    a[2] = 0
    return Time.utc(*a)
  end

end