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

Add to config/deploy.rb:

```ruby
    require 'capistrano/pg-capistrano'

    # if you haven't already specified
    set :rails_env, "production"

    # if you want to remove the local dump file after loading
    set :db_local_clean, true

    # if you want to remove the dump file from the server after downloading
    set :db_remote_clean, true

    # if you want to exclude table from dump
    set :db_ignore_tables, []

    # if you want to exclude table data (but not table schema) from dump
    set :db_ignore_data_tables, []

    # If you want to import assets, you can change default asset dir (default = system)
    # This directory must be in your shared directory on the server
    set :assets_dir, %w(public/assets public/att)
    set :local_assets_dir, %w(public/assets public/att)

    # if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
    set :locals_rails_env, "production"

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

    app:local:sync      || app:pull     # Synchronize your local assets AND database using remote assets and database
    app:remote:sync     || app:push     # Synchronize your remote assets AND database using local assets and database

    assets:local:sync   || assets:pull  # Synchronize your local assets using remote assets
    assets:remote:sync  || assets:push  # Synchronize your remote assets using local assets

    db:local:sync       || db:pull      # Synchronize your local database using remote database data
    db:remote:sync      || db:push      # Synchronize your remote database using local database data

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

* Add task for Typo3
* Add tests

Copyright (c) 2015 [Marcos Fadul - polargold], released under the MIT license
Copyright (c) 2015-2009 [Sébastien Gruhier - XILINUS], released under the MIT license
