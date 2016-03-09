require 'rubygems'
require 'bundler/setup'
require 'fileutils'
require 'logger'
require 'sinatra/activerecord/rake'

task :default do
  puts "Available tasks:"
  Rake.application.options.show_tasks = true
  Rake.application.options.full_description = false
  Rake.application.options.show_task_pattern = //
  Rake.application.display_tasks_and_comments
end

task :env do
  require "#{File.dirname(__FILE__)}/app.rb"
end

begin
  require 'rake/notes/rake_task'
rescue LoadError
end

begin
  require 'rspec/core/rake_task'
  desc 'Run all tests'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
rescue LoadError
end

namespace :db do
  task :load_config do
    require "./app"
  end
end

if defined? RSpec 
  namespace :spec do
    begin
      desc 'Run all model tests'
      RSpec::Core::RakeTask.new(:models) do |t|
        t.pattern = 'spec/models/**/*_spec.rb'
        t.rspec_opts = [ '--backtrace', '--colour', '-fd']
      end
    rescue LoadError
    end

    begin
      desc 'Run all route tests'
      RSpec::Core::RakeTask.new(:routes) do |t|
        t.pattern = 'spec/routes/**/*_spec.rb'
        t.rspec_opts = [ '--backtrace', '--colour', '-fd']
      end
    rescue LoadError
    end
  end
end

namespace :cron do
  task :expiration_emails do
    require "./app"
    User.send_expiration_emails
  end
  task :test do
    require "./app"
    User.cron_test
  end
end
