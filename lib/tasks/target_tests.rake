require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

RSpec::Core::RakeTask.new(:uptime => 'ci:setup:rspec') do |t|
  t.pattern = Dir.glob('test/frontend_tests/spec/firefly/uptime_spec.rb')
  t.rspec_opts = '--format --color'
  # t.rspec_opts << 'more options'
end

task :loop, [:task_name] do |t, args|
  5.times do
    Rake::Task[args[:task_name]].reenable
    Rake::Task[args[:task_name]].invoke
  end
end

task :default => :spec
