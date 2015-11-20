require 'yaml'

module Helpers
  def real_credentials_available?
    ::File.exists?(File.join(File.dirname(__FILE__), 'credentials.yml'))
  end
  
  def set_configuration_with_real_credentials
    cfg = ::YAML.load_file(File.join(File.dirname(__FILE__), 'credentials.yml'))
    
    ::Loopiator.configure do |config|
      cfg.each do |key, value|
        config.send("#{key}=", value)
      end
    end
  end
  
end