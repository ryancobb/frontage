require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

RSpec::Core::RakeTask.new(:uptime => 'ci:setup:rspec') do |t|
  t.pattern = Dir.glob('test/frontend_tests/spec/firefly/uptime_spec.rb')
  t.rspec_opts = '--format --color --failure-exit-code=0'
  # t.rspec_opts << 'more options'
end

task :default => :uptime
