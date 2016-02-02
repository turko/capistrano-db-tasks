module Asset
  extend self

  class Base
    attr_accessor :config, :output_file
    def initialize(cap_instance)
      @cap = cap_instance
    end
    def assets_dir
      @config['assets_dir']
    end
  end
  class Local < Base
    def initialize(cap_instance)
      super(cap_instance)
      @config = YAML.load(ERB.new(File.read(fetch(:db_config).to_s)).result)[fetch(:local_env).to_s]
      puts "Local Environment: #{@config}"
    end
  end

  def remote_to_local(cap)
    local_assets = Database::Local.new(instance)

    servers = Capistrano::Configuration.env.send(:servers)
    server = servers.detect { |s| s.roles.include?(:app) }
    port = server.netssh_options[:port] || 22
    user = server.netssh_options[:user]

    [cap.fetch(:assets_dir)].flatten.each do |dir|
      system("mkdir -p #{cap.fetch(:local_assets_dir)}/#{dir}")
      system("rsync -a --del --no-links -vv --progress #{self::exclude_arg(cap)} --rsh='ssh -p #{port}' #{user}@#{server}:#{cap.current_path}/#{dir} #{local_assets.assets_dir}/#{dir}")
    end
  end

  def local_to_remote(cap)
    local_assets = Assest::Local.new(instance)

    servers = Capistrano::Configuration.env.send(:servers)
    server = servers.detect { |s| s.roles.include?(:app) }
    port = server.netssh_options[:port] || 22
    user = server.netssh_options[:user]
    [cap.fetch(:assets_dir)].flatten.each do |dir|
      system("rsync -a --del -vv --progress #{self::exclude_arg(cap)} --rsh='ssh -p #{port}' ./#{local_assets.assets_dir}/#{dir} #{user}@#{server}:#{cap.current_path}/#{dir}")
    end
  end

  def to_string(cap)
    [cap.fetch(:assets_dir)].flatten.join(" ")
  end

  def exclude_arg(cap)
    " --exclude '/" + cap.fetch(:assets_excludes).join("' --exclude '/")+"' " unless cap.fetch(:assets_excludes).count()==0
  end
end
