require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'fileutils'
require 'logger'

task :default do
  puts "Available tasks:"
  Rake.application.options.show_tasks = true
  Rake.application.options.full_description = false
  Rake.application.options.show_task_pattern = //
  Rake.application.display_tasks_and_comments
end

task :env do
  require "#{File.dirname(__FILE__)}/application.rb"
end

begin
  desc 'Run all tests'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.rspec_opts = [ '--backtrace', '--colour', '-fd']
  end
rescue LoadError
end

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

namespace :db do
  desc 'Run database migrations'
  task :migrate => %w(env) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc 'Rollback last migration'
  task :rollback => %w(env) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.rollback('db/migrate')
  end

  desc 'Reset the database'
  task :reset => %w(env) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.down('db/migrate')
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  desc 'Output the schema to db/schema.rb'
  task :schema => %w(env) do
    File.open('db/schema.rb', 'w') do |f|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, f)
    end
  end

  desc "Create a migration at ./db/migrate/{NAME}"
  task :create_migration do
    name = ENV['NAME']
    abort("no NAME specified. use `rake db:create_migration NAME=create_users`") if !name

    migrations_dir = File.join("db", "migrate")
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S") 
    filename = "#{version}_#{name}.rb"
    migration_name = name.gsub(/_(.)/) { $1.upcase }.gsub(/^(.)/) { $1.upcase }

    FileUtils.mkdir_p(migrations_dir)

    open(File.join(migrations_dir, filename), 'w') do |f|
      f << (<<-EOS).gsub("      ", "")
      class #{migration_name} < ActiveRecord::Migration
        def change
        end
      end
      EOS
    end
    puts "New migration created at #{migrations_dir}/#{filename}"
  end

end