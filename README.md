PGCapistrano
=================

Add database AND assets tasks to capistrano for polargold project.
It only works with capistrano 3.

Currently

* It only supports mysql and postgresql (both side remote and local)
* Synchronize assets remote to local and local to remote

Commands mysql, mysqldump (or pg\_dump, psql), bzip2 and unbzip2 (or gzip) must be in your PATH

Feel free to fork and to add more database support or new tasks.

Install
=======

Add it as a gem:

```ruby
  gem "pg-capistrano", :git => 'git@bitbucket.org:polargold/infrastructure-pg-capistrano.git'
```

Create database.yml like:
```
production:
  database: "database_name"
  username: "username"
  password: "password"
  host: "host"
  adapter: "mysql"

local:
  database: "database_name"
  username: "username"
  password: "password"
  host: "host"
  adapter: "mysql"

```

Add to config/deploy.rb:

```ruby
    require 'capistrano/pg-capistrano'

    # Set configuration file. It must exist in the share_path and in local system (default = app/config/database.yml)
    set :db_config, 'app/config/database.yml'

    # if you haven't already specified
    set :stage, "production"

    # If you want to import assets, you can change default asset dir (default = _static)
    set :local_assets_dir, "_static"

    # Files and Folder to sync. This directory must be in your shared directory on the server
    set :assets_dir, %w(web/fileadmin web/uploads)

    # if you want to remove the local dump file after loading
    set :db_local_clean, true

    # if you want to remove the dump file from the server after downloading
    set :db_remote_clean, true

    # if you want to exclude table from dump
    set :db_ignore_tables, []

    # if you want to exclude table data (but not table schema) from dump
    set :db_ignore_data_tables, []

    # if you want to work on a specific local environment (default = ENV['LOCAL_ENV'] || 'local')
    set :local_env, "local"

    # if you are highly paranoid and want to prevent any push operation to the server
    set :disallow_pushing, true

    # if you prefer bzip2/unbzip2 instead of gzip
    set :compressor, :bzip2

```

Add to .gitignore
```yml
    /db/*.sql
```


[How to install bzip2 on Windows](http://stackoverflow.com/a/25625988/3324219)

Available tasks
===============

    app:local:sync      || app:pull     # Update local system assets AND database using remote instance assets and database
    app:remote:sync     || app:push     # Update remote instance assets AND database using local system assets and database

    assets:local:sync   || assets:pull  # Update local system assets using remote instance assets
    assets:remote:sync  || assets:push  # Update remote instance assets using local system assets

    db:local:sync       || db:pull      # Update local system database using remote instance database data
    db:remote:sync      || db:push      # Update remote instance database using local system database data

Example
=======

    cap production db:pull


Contributors
============

* Sébastien Gruhier (https://github.com/sgruhier)
* tilsammans (http://github.com/tilsammansee)
* bigfive    (http://github.com/bigfive)
* jakemauer  (http://github.com/jakemauer)
* tjoneseng  (http://github.com/tjoneseng)

TODO
====

* Send assets path in database.yml to be able to use it direct on the server environment
* Add task for Typo3
* Add tests

Copyright (c) 2015 [Marcos Fadul - polargold], released under the MIT license
Copyright (c) 2015-2009 [Sébastien Gruhier - XILINUS], released under the MIT license
