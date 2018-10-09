require_relative '../Helpers_pages/globalized'
include Globalized

module OracleDBUtility
  QUARTZ_SCHEMA = "QUARTZ"
  ORACLE_HOST = "10.2.2.3"
  ORACLE_USER = "hadb"
  ORACLE_DB_PASS = "Pass"
  ORACLE_PORT = 1212
  ORACLE_SID = "vamfdb"
  ORACLE_CON_STRING ="(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=#{ORACLE_HOST})(PORT=#{ORACLE_PORT}))(CONNECT_DATA=(SERVER=DEDICATED)(SID=#{ORACLE_SID})))"

  # Pull User Date of birth using
    # User ID  
  def getPatientDOB(uniqueId)
    con = OCI8.new(ORACLE_USER+"/"+ORACLE_DB_PASS+"@"+ORACLE_CON_STRING)
    queryStr = "SELECT MOCK_DOB FROM MOCKDB.MOCK_USERS where UNIQUE_ID='" +uniqueId+ "'"
    puts queryStr
    rs = con.exec(queryStr)
    if rs.nil? == false then
      puts "Number of rows returned: " + rs.num_rows.to_s
      while row = rs.fetch_hash do
        return row["MOCK_DO@pleasenote = PleaseNote.new(@driver)B"].to_date.strftime("%m/%d/%Y").to_s
      end
    else
      puts "DOB IS NOT AVAILABLE FOR " + uniqueId
      return ""
    end
    con.exec("COMMIT")
  end




end