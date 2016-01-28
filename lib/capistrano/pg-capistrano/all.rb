
require 'capistrano/pg-capistrano/typo3'

load File.expand_path("../tasks/buildDevelop.rake", __FILE__)
load File.expand_path("../tasks/local.rake", __FILE__)
load File.expand_path("../tasks/setup.rake", __FILE__)