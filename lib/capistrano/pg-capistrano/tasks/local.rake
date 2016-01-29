set :composer_local_install_flags, '--prefer-dist --no-interaction --quiet' unless fetch(:composer_local_install_flags)
set :composer_json_local_path, 'web/composer.json' unless fetch(:composer_json_local_path)

desc 'Config environment'
task :local do
  load deploy_config_path

  # call composer install
  composer_json_path = (Pathname.new ".") + fetch(:composer_json_local_path)
  system("cd #{composer_json_path.dirname} && composer install #{fetch(:composer_local_install_flags)}")
  puts "composer install #{fetch(:composer_local_install_flags)}"

end