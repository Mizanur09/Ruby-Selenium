require_relative '../Helpers_pages/globalized'
require_relative '../Helpers_pages/rspec_helper'
include Globalized

describe "[Story 'Number' Provide information about this Test" do
  before(:all) do
    initializeConfigurations($LOCAL)
    initializeAllObjects
  end
  after(:all) do
    quitDriver()
  end

  context "AC 'Number' Add AC Title" do
    before(:each)do
      puts 'Test Up the DataBase'
    end

    after(:each)do
      puts 'Reset the DataBase'
    end

    it "TC 'Number' Add TC Title" do
      puts 'Browser has been Opened'
    end

    it "TC 'Number' Add TC Title" do
      puts 'Test is completed'
    end
  end
end