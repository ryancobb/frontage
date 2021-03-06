require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

namespace :frontend do
  RSpec::Core::RakeTask.new(:uptime => 'ci:setup:rspec') do |t|
    t.pattern = Dir.glob('test/frontend_tests/spec/firefly/uptime_spec.rb')
  end

  RSpec::Core::RakeTask.new(:dummy => 'ci:setup:rspec') do |t|
    t.pattern = Dir.glob('test/frontend_tests/spec/firefly/dummy_spec.rb')
  end

  RSpec::Core::RakeTask.new(:dummy2 => 'ci:setup:rspec') do |t|
    t.pattern = Dir.glob('test/frontend_tests/spec/firefly/dummy2_spec.rb')
  end

  task :default => :uptime
end
