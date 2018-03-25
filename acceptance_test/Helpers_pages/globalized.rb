module Globalized
  # require all gem dependency files below,

  require 'page-object'
  require 'rspec'
  require 'json'
  require 'selenium-webdriver'
  require 'rubygems'
  require 'active_support/time'
  require 'json'
  require 'date'
  require 'time'

# require 'mysql'

  require 'net/http'
  require 'rexml/document'
  require 'jquery'
  require 'uri'
  require 'mongo'
  require 'mongo-import'
  require 'bson'
  require 'data_magic'

  include TypeaheadSelectionList
  include RSpec::Expectations

  ## require all the modual below,
  require_relative '../../module/ContactsUtility'
  require_relative '../../module/DriverUtility'

  ## include all the module below,
  include ContactsUtility
  include DriverUtility

 ## require all the pages below,
  require_relative '../../pages/base_page'
  # require_relative 'more files as you will add'









 ## initialize all the page object below.
  def initializeAllObjects
    @Function = Functions.new(@driver)
  #   initialize more file as created
  end


end