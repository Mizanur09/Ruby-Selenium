




## declare an exclusion filter.. using this tags exclusion filter individual test can be run.
RSpec.configure do |c|
  c.filter_run_excluding :broken => false
  c.filter_run_excluding :regression => true
  c.filter_run_excluding :acceptance => true
  c.filter_run_excluding :smoketest => true
end

RSpec.configure do |config|
  config.include AllureRSpec::Adaptor
end

AllureRSpec.configure do |config|
  config.output_dir = File.join(Dir.home(), "~/Ruby-Selenium/allure-report/allure_results") # add the path where you want to export the data.
  config.clean_dir = true
end