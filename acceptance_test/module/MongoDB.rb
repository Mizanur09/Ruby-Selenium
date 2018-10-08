require_relative '../Helpers_pages/globalized'
include Globalized

include Mongo
include MongoImport
module MongoUtility

  HOSTANDPORT = 'Please enter Host port number here'

  def printAllCollections
    connection = Mongo::Client.new([HOSTANDPORT])
    connection.database_names.each do |name|
      db = connection.use(name)
      db.collections.each do |collection|
        puts "#{name} - #{collection.name}"
      end
    end
  end







end
