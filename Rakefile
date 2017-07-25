# require('./app')
require('sinatra/activerecord')
require('sinatra/activerecord/rake')
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: :spec
namespace(:db) do
  task(:load_config)
end
