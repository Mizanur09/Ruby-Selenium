# Ruby install instructions
  * Download ruby https://rubyinstaller.org/downloads/
  * Click ok on the popup
  * Checkpoint on I agree the license and click next
  * Checkpoint Add Ruby executable to path and click install
  * Click on finish once it done.
# Ruby install from Terminal
	* Open terminal 
		* gem install ruby
	* Navigate to your project using terminal/ Command line prompts
		* cd Desktop/Ruby-selenium/
	* Create Gemfile and add dependencies as follows 
		* add source source 'https://rubygems.org'
		* gem 'nokogiri'
		* gem 'data_magic'
		* gem 'selenium-webdriver', '~>2.53.0'
		* gem 'rspec', '~> 2.14.1'
		* gem 'rspec-expectations', '~> 2.14.5'
		* gem 'rspec_junit_formatter', '~> 0.2.0'
		* gem 'test-unit', '~> 3.0.9'
		* gem 'debugger-linecache', '~> 1.2.0'
		* gem 'ci_reporter', '~> 2.0.0'
		* gem 'json'
		* gem 'activesupport', '~> 4.2.0'
		* gem 'i18n', '~> 0.7.0'
		* gem 'ruby-jquery', '~> 0.0.1'
		* gem 'bson', '~> 4.3.0'
		* gem 'mongo','~> 2.4.1'
		* gem 'bson_ext', '~> 1.5.1'
		* gem 'mongo-import'
		* gem 'compass', '~> 1.0.3'
		* gem 'require_all'
		* gem 'allure-rspec', '~> 0.5.0'
		* gem 'uuid'
		* gem 'mimemagic'
# Run installation 
		* gem install bundler
		* gem install bundle
# Check your ruby
		* which ruby (should show the path)
		* ruby -v (should show current version)
# Check your bundler and bundle files and path
		* which bundler (should show the path)
		* bundler -v (should show current version)
		* which bundle (should show the path)
		* bundle -v (should show current version)
# Download Ruby Devkit 
  * Navigate to this URL "http://rubyinstaller.org/downloads/"
  * Make sure to Download zip file (DEVELOPMENT KIT)
  * Unzip that file
# Ruby DevKit install from Terminal
  * Navigate to Ruby Devkit file in download Folder Using Terminal
  * Run Following line 
       * ruby dk.rb init
       * Update the Config file 
           * Add path of your Current ruby folder from your "~/" or $HOME dir
       * ruby dk.rb install
       * gem install rdiscount --platform=ruby
  * Navigate to Project folder
  * Run Bundle Update 
       

# Note: you should have Ruby installed on your computer. *-*
# Devkit will help you to work with MongoDB, oracle, Json and bson gems +_+
