require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler'
require 'bundler/gem_tasks'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the pg_capistrano plugin.'
Rake::TestTask.new(:test) do |t|
  # t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the pg_capistrano plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PgCapistrano'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
