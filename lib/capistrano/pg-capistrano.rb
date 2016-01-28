
# Load DSL and set up stages
require 'capistrano/setup'
#
# # Include default deployment tasks
require 'capistrano/deploy'
#
require 'capistrano/composer'

require File.expand_path("#{File.dirname(__FILE__)}/dsl/task_enhancements")

require 'capistrano/pg-capistrano/util'

require 'capistrano/db-tasks/dbtasks'

require 'capistrano/pg-capistrano/all'

# require File.expand_path("#{File.dirname(__FILE__)}/pg-capistrano/util")
# require File.expand_path("#{File.dirname(__FILE__)}/pg-capistrano/typo3/typo3") if respond_to?(:stage)
# require File.expand_path("#{File.dirname(__FILE__)}/db-tasks/dbtasks") if respond_to?(:stage)
#
# load File.expand_path(File.join(File.dirname(__FILE__),'pg-capistrano/build/local.rake'))
# load File.expand_path(File.join(File.dirname(__FILE__),'pg-capistrano/build/buildDevelop.rake'))