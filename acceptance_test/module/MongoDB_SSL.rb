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

  Connection = Mongo::Client.new([ HOSTANDPORT ],
                                 :user => USERID,
                                 :password => PASSWORD,
                                 :ssl => true,
                                 :connect_timeout => CONNECT_TIMEOUT,
                                 :max_pool_size => MAX_POOL_SIZE,
                                 :ssl_verify => false)



  def Create_Database_Users
    Connection.database_names.each do |name|
      db = Connection.use(name)
      begin
        db.command({
                       'createUser' => name,
                       'pwd' => PASSWORD,
                       'roles' => [
                           { 'role' => 'dbOwner', 'db' => name }
                       ]
                   })
          rescue => e
            puts 'Error Creating User: ' + e.to_s
      end
    end
  end

  def printAllCollections
    Connection.database_names.each do |name|
      db = Connection.use(name)
      db.Connection.each do |collection|
        puts "#{name} - #{collection.name}"
      end
    end
  end

  def removeCollection(collectionName, dbName)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :user => dbName, :password => PASSWORD,
                            :database => dbName, :ssl => true,
                            :connect_timeout => CONNECT_TIMEOUT,
                            :max_pool_size => MAX_POOL_SIZE, :ssl_verify => false)
    @db[collectionName].drop
    puts "removed All documents for " + collectionName
  end

end