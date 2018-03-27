module Globalized
  require_relative 'helper_page'

  ## require all the modual below,
  require_relative '../module/ContactsUtility'
  require_relative '../module/DriverUtility'
  require_relative '../module/Common_Functions'

  ## include all the module below,
  include ContactsUtility
  include DriverUtility
  include Functions

  ## require all the pages below,
  require_relative '../pages/base_page'
  ## require_relative 'add more files as created'


  ## initialize all the page object below.
  def initializeAllObjects
    @basePage = Base_page.new(@driver)
    ##   initialize more file as created
  end


end