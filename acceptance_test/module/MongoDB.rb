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


end
