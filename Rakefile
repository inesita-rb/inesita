require 'bundler'
Bundler.require
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'opal/rspec/rake_task'
require 'opal/browser'

ENV['SPEC_OPTS'] = '--color'

RSpec::Core::RakeTask.new(:spec_lib) do |t|
  t.pattern = 'spec/lib/**/*_spec.rb'
end

Opal::RSpec::RakeTask.new(:spec_opal) do |s, t|
  t.pattern = 'spec/opal/**/*_spec.rb'
  RailsAssets.load_paths.each do |p|
    s.append_path p
  end if defined?(RailsAssets)
end

task :default => [:spec_lib, :spec_opal]
