require_relative '../Helpers_pages/globalized'
include Globalized

include Mongo
include MongoImport

module MongoUtilitySSL

  HOSTANDPORT = 'Please enter Host port number here'
  USERID = 'Please provide the USER ID here'
  PASSWORD = 'Please provide the password here'
  CONNECT_TIMEOUT = '20'
  MAX_POOL_SIZE = '100'

end