require_relative '../Helpers_pages/globalized'
include Globalized

include Mongo
include MongoImport
module MongoUtility

  HOSTANDPORT = 'Please enter Host port number here'

# This Methods will collect and Print out All Collections Using For-loop
  def printAllCollections
    connection = Mongo::Client.new([HOSTANDPORT])
    connection.database_names.each do |name|
      db = connection.use(name)
      db.collections.each do |collection|
        puts "#{name} - #{collection.name}"
      end
    end
  end

# Remove Collection By Proving Following info
  # Collection-name
  # Database-name
  def removeCollection(collectionName, dbName)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :database => dbName)
    @db[collectionName].drop
    # puts "[removeCollection] removed All documents for " + collectionName
  end

# Update Documents by providing following info
  # Collection Name
  # DataBase name
  # object ID
  # Column Name
  # Value
  def updateDocument(collectionName, dbName, objId, columnName, value)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :database => dbName)
    documents = @db[collectionName]
    documents.update_one({:_id => BSON::ObjectId(objId)},
                         {"$set" => {columnName => value}})
  end

  # Remove Document by Providing following info
    # Collection Name
    # DataBase Name
    # Object ID
  def removeDocumentByObjectId(collectionName, dbName, objId)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :database => dbName)
    documents = @db[collectionName]
    documents.remove({:_id => BSON::ObjectId(objId)})
  end

  #Insert Collection/File by Providing following info
    # Collection Name
    # DataBase Name
    # File Name
  def insertCollection(collectionName, dbName, fileName)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :database => dbName)
     snapshot fileName,
             @db,
             :path => 'spec/snapshots'
    puts "[insertCollection] imported Collection " + collectionName
  end

  # Get Document/file By Providing following info
    # Collection Name
    # DataBase Name
    # Object ID
    # Column Name
  def getDocumentByObjId(collectionName, dbName, objId, columnName)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :database => dbName)
    document = @db[collectionName].find({:_id => BSON::ObjectId(objId)},
                                        :fields => [columnName]).to_a
    puts "[getDocumentByObjId ] " + document.to_s
    return document
  end

  # get last Document By User Identification Using Following information
    # Collection Name
    # DataBase Name
    # Authority
    # Unique Value
    # Column name
  def getLatestDocumentByUserIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :user => dbName,
                            :password => '1234',
                            :database => dbName,
                            :ssl => true,
                            :connect_timeout => 20,
                            :max_pool_size => 100,
                            :ssl_verify => false)
    document = @db[collectionName].find({"patientIdentifier.uniqueId" => uniqueIdValue,
                                         "patientIdentifier.assigningAuthority"=> assigningAuthorityValue},
                                        :fields => [columnName]).sort({'createdDate' => -1})

    return document
  end

# Get Document/File By UniqueID
  # Collection Name
  # DataBase Name
  # Assigning Authority Value
  # Unique Id Value
  # ColumnName
  def getDocumentByPatientIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    @db = Mongo::Client.new([ HOSTANDPORT ],
                            :database => dbName)
    document = @db[collectionName].find({"patientIdentifier.uniqueId" => uniqueIdValue,
                                         "patientIdentifier.assigningAuthority"=> assigningAuthorityValue},
                                        :fields => [columnName])
    return document
  end

  # Verify Column Deleted by Providing following info
    # Collection Name
    # DataBase Name
    # Object Id
    # Column name
  def verifyColumnDeleted(collectionName, dbName, objId, columnName)
    document = getDocumentByObjId(collectionName, dbName, objId, columnName)
    isDeleted = true
    for record in document
      if record[columnName] == false
        isDeleted = false
        break
      end
    end
    puts "[Verify Column Is Deleted] objId: " + objId + " - columnName: " + columnName + " IsDeleted: " + isDeleted.to_s
    return isDeleted
  end

  # Retrieve row by get Document using object ID
    # This methods will bring out multiple row
  def retrieveThisFieldInDocumentWithMultiRows(collectionName, dbName, objId, columnName)
    document = getDocumentByObjId(collectionName, dbName, objId, columnName)
    outPut = ""
    document.each { |record|
      puts record[columnName]
      if record[columnName] != nil then
        outPut = record[columnName] + ',' + outPut.to_s
      else
        output = "" + "," + output.to_s
      end
    }
    puts "outPut=" + outPut.to_s
    return outPut
  end

  def retrieveLatestRecordFieldInDocument(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    document = getLatestDocumentByUserIdentifier(collectionName, dbName, assigningAuthorityValue, uniqueIdValue, columnName)
    for record in document
      puts "record[" + columnName + "]=" + record[columnName].to_s
      return record[columnName]
    end
  end

  # Collect all the document from dataBase keep it in Array Using
    # Collection Name
    # DataBase name
  def retreiveAllDocumentsInCollection(collectionName, dbName)
    documentArray = []
    @db = Mongo::Client.new([ HOSTANDPORT ], :database => dbName)
    documents = @db[collectionName].find()
    documents.each do | document |
      documentArray << document
    end
    return documentArray
  end









end
