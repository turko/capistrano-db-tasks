require 'erb'
require 'pathname'

desc 'Build environment for the first time'
task :buildDevelop do
  # :deploy_config_path
  load deploy_config_path

  static_dir = Pathname.new(fetch(:local_assets_dir))
  app_dir = Pathname.new('app')
  web_dir = Pathname.new('web')
  db_dir = Pathname.new('db')
  vm_dir = Pathname.new('_vm')

  # Create important directories
  unless File.directory?(static_dir)
    mkdir_p static_dir
  end
  unless File.directory?(db_dir)
    mkdir_p db_dir
  end

  # Create capistrano.yml
  if File.exists?(fetch(:db_config))
    warn "[skip] #{fetch(:db_config)} already exists"
  else
    db_config_template = File.expand_path("../../templates/capistrano.yml.erb", __FILE__)
    ask(:local_database_name, 'localdev', echo: false)
    ask(:local_database_username, 'root', echo: false)
    ask(:local_database_password, 'root', echo: false)
    ask(:local_database_host, '127.0.0.1', echo: false)
    ask(:local_database_adapter, 'mysql', echo: false)
    File.open(fetch(:db_config), 'w+') do |f|
      f.write(ERB.new(File.read(db_config_template)).result(binding))
      puts I18n.t(:written_file, scope: :capistrano, file: fetch(:db_config))
    end
  end

  # If this is typo3 we link the config
  if File.exists?(app_dir.join('config/LocalConfigurationLocal.php')) && !File.exists?(web_dir.join('typo3conf/LocalConfigurationExtend.php'))
    # ln -s ../../app/config/LocalConfigurationLocal.php web/typo3conf/LocalConfigurationExtend.php
    system("ln -sfn ../../#{app_dir.join('config/LocalConfigurationLocal.php')} #{web_dir.join('typo3conf/LocalConfigurationExtend.php')}")
    puts I18n.t(:written_file, scope: :capistrano, file: app_dir.join('config/LocalConfigurationLocal.php'))
  else
    warn "[skip] #{web_dir.join('typo3conf/LocalConfigurationExtend.php')} already exists"
  end

  # Link static resources
  fetch(:assets_dir).each do |directory|
    system("ln -sfn ../#{(static_dir + directory).cleanpath} #{directory[0...-1]}")
    puts I18n.t(:written_file, scope: :capistrano, file: " link from #{(static_dir + directory).cleanpath} to #{directory[0...-1]}")
  end
  # Link app resources
  absolute_path = Pathname.new("/var/www")
  fetch(:assets_excludes).each do |directory|
    system("ln -sfn #{(absolute_path + app_dir + "resources" + directory).cleanpath} #{directory}")
    puts I18n.t(:written_file, scope: :capistrano, file: " link from #{(absolute_path + app_dir + "resources" + directory).cleanpath} to #{directory}")
  end

  # Create VM
  if !File.directory?(vm_dir) && Util.prompt("Do you want to create a vm?")
    system("git clone git@bitbucket.org:polargold/infrastructure-vagrant.git #{vm_dir}")
    system("cd #{vm_dir} && bundler exec librarian-puppet install")
    system("cd #{vm_dir} && vagrant up")
  end

  puts "Everything is ready now. Please log into your VM and do the following steps:"
  puts "1. cd /var/www"
  puts "2. bundle install"
  puts "3. cap <favorite stage> app:pull"
  puts "4. cap local"

end