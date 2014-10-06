require 'foodcritic'
require 'foodcritic/rake_task'
require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

# Style tests (Foodcritic / Tailor)
FoodCritic::Rake::LintTask.new

desc 'Run Style Tests'
task :style => [:foodcritic]

# ChefSpec
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = '--color --format progress'
end

desc 'Generate ChefSpec coverage report'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].invoke
end

# Test Kitchen
begin
  Kitchen::RakeTasks.new
rescue
  # if creating the TK rake tasks fails, it's probably
  # because we don't have Vagrant installed.  Continue
  # silently without TK support
end

# if we are running inside the CI pipeline, turn on
# xUnit-style test reports
if ENV.key?('CI_BUILD')
  require 'ci/reporter/rake/rspec'
  task :spec => 'ci:setup:rspec'
end
