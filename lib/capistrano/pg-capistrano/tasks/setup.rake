require 'erb'
require 'pathname'
namespace :deploy do

  desc 'Set up staging'
  task :setup do
    invoke 'deploy:check:directories'
    invoke 'deploy:check:linked_dirs'
    invoke 'deploy:setup:files'
  end

  namespace :setup do
    task :files do
      on release_roles :all do

        # upload .htaccess from path
        if !(test "[ -f #{shared_path + 'web/.htaccess'} ]")
          ask(:htaccess_path, './web/.htaccess', echo: true)
          htaccess_dir = Pathname.new(fetch(:htaccess_path))
          if File.exists?(htaccess_dir)
            info "Uploading #{htaccess_dir} to #{shared_path + 'web/.htaccess'}"
            upload! File.open(htaccess_dir), (shared_path + 'web/.htaccess').to_s
            info "DONE! .htaccess uploaded successfully."
          else
            error "[error] #{htaccess_dir} not found"
          end
        end

        # create robots.txt
        if !(test "[ -f #{shared_path + 'web/robots.txt'} ]")
          if Util.prompt('Do you want to allow robots and bots to the site')
            execute %{echo "User-agent: *" > #{shared_path + 'web/robots.txt'}}
            execute %{echo "Disallow:" >> #{shared_path + 'web/robots.txt'}}
          else
            execute %{echo "User-agent: *" > #{shared_path + 'web/robots.txt'}}
            execute %{echo "Disallow: /" >> #{shared_path + 'web/robots.txt'}}
          end
          info "DONE! robots.txt created"
        end

        # create capistrano.yml
        if test "[ -f #{shared_path + fetch(:db_config)} ]"
          warn "[skip] #{fetch(:db_config)} already exists"
        else
          db_config_template = File.expand_path("../../templates/capistrano.yml.erb", __FILE__)
          ask(:local_database_name, 'localdev', echo: true)
          ask(:local_database_username, 'root', echo: true)
          ask(:local_database_password, 'root', echo: false)
          ask(:local_database_host, '127.0.0.1', echo: true)
          ask(:local_database_adapter, 'mysql', echo: true)
          capistrano_yml = ERB.new(File.read(db_config_template)).result(binding)
          # puts capistrano_yml
          execute :mkdir, '-p', (shared_path + fetch(:db_config)).dirname
          upload! StringIO.new(capistrano_yml), (shared_path + fetch(:db_config)).to_s
          info I18n.t(:written_file, scope: :capistrano, file: fetch(:db_config))
        end

        # touch all other files and tell the user about it.
        fetch(:linked_files).each do |file|
          unless test "[ -f #{(shared_path + file).to_s} ]"
            ask(:file_path, file, echo: true)
            file_path = Pathname.new(fetch(:file_path))
            if File.exists?(file_path)
              upload! File.open(file_path), (shared_path + file).to_s
            else
              exit 1
            end
          end
        end
      end
    end
  end
end