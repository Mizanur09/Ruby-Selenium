




## declare an exclusion filter.. using this tags exclusion filter individual test can be run.
RSpec.configure do |c|
  c.filter_run_excluding :broken => false
  c.filter_run_excluding :regression => true
  c.filter_run_excluding :acceptance => true
  c.filter_run_excluding :smoketest => true
end
