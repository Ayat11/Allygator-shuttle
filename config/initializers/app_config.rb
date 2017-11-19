class AppConfig
  def self.load
    config_file = File.join(Rails.root, "config", "application.yml")

    if File.exists?(config_file)
      config = YAML.load(File.read(config_file))["default"].merge(YAML.load(File.read(config_file))[::Rails.env])
      config.keys.each do |key|
        cattr_accessor key
        send("#{key}=", config[key])
      end
    end
  end

  def self.method_missing(*args)
    nil
  end

end

AppConfig.load

raise "server_host variable should be initialized in your application.yml" if !AppConfig.respond_to?(:server_host) || AppConfig.server_host.nil?