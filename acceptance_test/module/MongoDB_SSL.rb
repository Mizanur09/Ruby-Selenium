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

  def Update_given_dataBase(dbName)
    Mongo::Client.new([ HOSTANDPORT ],
                      :user => dbName,
                      :password => PASSWORD,
                      :database => dbName,
                      :ssl => true,
                      :connect_timeout => CONNECT_TIMEOUT,
                      :max_pool_size => MAX_POOL_SIZE,
                      :ssl_verify => false)
  end

  def printAllCollections
    Connection.database_names.each do |name|
      db = Connection.use(name)
      db.Connection.each do |collection|
        puts "#{name} - #{collection.name}"
      end
    end
  end

  def insertCollection(collectionName, dbName, fileName)
    system('mongoimport --host 10.0.0.0:12121 --username ' +
               dbName + ' --password 1234 --db ' +
               dbName + ' --collection '+
               collectionName + ' --ssl --sslAllowInvalidCertificates --type json --file '+
               Dir.pwd + '/spec/snapshots/' +
               fileName + '.json')
    puts "[insertCollection] imported Collection " + collectionName
  end

  def removeCollection(collectionName, dbName)
    @db = Update_given_dataBase(dbName)
    @db[collectionName].drop
    puts "removed All documents for " + collectionName
  end

  def updateDocument(collectionName, dbName, objId, columnName, value)
    @db = Update_given_dataBase(dbName)
    documents = @db[collectionName]
    documents.update_one({:_id => BSON::ObjectId(objId)},
                         {"$set" => {columnName => value}})
  end

  def removeDocumentByObjectId(collectionName, dbName, objId)
    @db = Update_given_dataBase(dbName)
    documents = @db[collectionName]
    documents.remove({:_id => BSON::ObjectId(objId)})
  end



end