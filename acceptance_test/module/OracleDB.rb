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

  



end