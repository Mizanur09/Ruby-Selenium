require_relative '../module/DriverUtility'


module ContactsUtility
  include DriverUtility

  def helper_get_TestPatientID
    @TEST_PATIENT_ID = "PATIENT_ID"
    return @TEST_PATIENT_ID
  end
  
  def helper_setTestDates

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


  end
end
