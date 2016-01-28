module Asset
  extend self

  def remote_to_local(cap)
    servers = Capistrano::Configuration.env.send(:servers)
    server = servers.detect { |s| s.roles.include?(:app) }
    port = server.netssh_options[:port] || 22
    user = server.netssh_options[:user]

    [cap.fetch(:assets_dir)].each do |dir|
      #puts "rsync -a --del -L -K -vv --progress --rsh='ssh -p #{port}' #{user}@#{server}:#{cap.current_path}/#{dir} #{cap.fetch(:local_assets_dir)}/#{dir}"
      system("mkdir -p #{cap.fetch(:local_assets_dir)}/#{dir}")
      system("rsync -a --del --no-links -vv --progress #{self::exclude_arg(cap)} --rsh='ssh -p #{port}' #{user}@#{server}:#{cap.current_path}/#{dir} #{cap.fetch(:local_assets_dir)}/#{dir}")
    end
  end

  def local_to_remote(cap)
    servers = Capistrano::Configuration.env.send(:servers)
    server = servers.detect { |s| s.roles.include?(:app) }
    port = server.netssh_options[:port] || 22
    user = server.netssh_options[:user]
    [cap.fetch(:assets_dir)].each do |dir|
      #puts "rsync -a --del -L -K -vv --progress --rsh='ssh -p #{port}' ./#{cap.fetch(:local_assets_dir)}/#{dir} #{user}@#{server}:#{cap.current_path}/#{dir}"
      system("rsync -a --del -vv --progress #{self::exclude_arg(cap)} --rsh='ssh -p #{port}' ./#{cap.fetch(:local_assets_dir)}/#{dir} #{user}@#{server}:#{cap.current_path}/#{dir}")
    end
  end

  def to_string(cap)
    [cap.fetch(:assets_dir)].flatten.join(" ")
  end

  def exclude_arg(cap)
    " --exclude '/" + cap.fetch(:assets_excludes).join("' --exclude '/")+"' " unless cap.fetch(:assets_excludes).count()==0
  end
end
