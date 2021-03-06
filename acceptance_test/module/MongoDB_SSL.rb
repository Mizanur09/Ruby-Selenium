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

  def getDocumentByObjId(collectionName, dbName, objId, columnName)
    @db = Update_given_dataBase(dbName)
    document = @db[collectionName].find({:_id => BSON::ObjectId(objId)},
                                        :fields => [columnName]).to_a
    puts "[getDocumentByObjId ] " + document.to_s
    return document
  end

  def getLatestDocumentByUserIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    @db = Update_given_dataBase(dbName)
    document = @db[collectionName].find({"UserIdentifier.uniqueId" => uniqueIdValue,
                                         "UserIdentifier.assigningAuthority"=> assigningAuthorityValue},
                                        :fields => [columnName]).sort({'createdDate' => -1})
    return document
  end

  def getDocumentByUserIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    @db = Update_given_dataBase(dbName)
    document = @db[collectionName].find({"UserIdentifier.uniqueId" => uniqueIdValue,
                                         "UserIdentifier.assigningAuthority"=> assigningAuthorityValue},
                                        :fields => [columnName])
    return document
  end

  def verifyColumnDeleted(collectionName, dbName, objId, columnName)
    document = getDocumentByObjId(collectionName, dbName, objId, columnName)
    isDeleted = true
    for record in document
      if record[columnName] == false
        isDeleted = false
        break
      end
    end
    puts "[verifyNotificationDeleted ] objId: " + objId + " - columnName: " + columnName + " IsDeleted: " + isDeleted.to_s
    return isDeleted
  end


  def retrieveThisFieldInDocumentWithMultiRows(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    document = getDocumentByUserIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    outPut = ""
    document.each { |record|
      puts record[columnName] + '####'
      if record[columnName] != nil then
        outPut = record[columnName] + ',' + outPut.to_s
      else
        output = "" + "," + output.to_s
      end
    }
    puts "outPut= " + outPut.to_s
    return outPut
  end

  def retrieveLatestRecordFieldInDocument(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    document = getLatestDocumentByUserIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    for record in document
      puts "record[" + columnName + "]=" + record[columnName].to_s
      return record[columnName]
    end
  end

  def retreiveAllDocumentsInCollection(collectionName, dbName)
    documentArray = []
    @db = Update_given_dataBase(dbName)
    documents = @db[collectionName].find()
    documents.each do | document |
      documentArray << document
    end
    return documentArray
  end



end