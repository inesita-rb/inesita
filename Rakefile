require 'bundler'
Bundler.require
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'opal/rspec/rake_task'

ENV['SPEC_OPTS'] = '--color'

RSpec::Core::RakeTask.new(:spec_lib) do |task|
  task.pattern = 'spec/lib/**/*_spec.rb'
end

Opal::RSpec::RakeTask.new(:spec_opal) do |_server, task|
  task.pattern = 'spec/opal/**/*_spec.rb'
  task.default_path = 'spec/opal'
end

task default: [:spec_lib, :spec_opal]
