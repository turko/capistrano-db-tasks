require 'capistrano'

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/composer'

require File.expand_path("#{File.dirname(__FILE__)}/capistrano/dsl/task_enhancements")

require 'capistrano/pg-capistrano/util'

require 'capistrano/db-tasks/dbtasks'

require 'capistrano/pg-capistrano/all'
