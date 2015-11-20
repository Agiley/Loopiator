module Helpers
  def real_credentials_available?
    File.exists?(File.join(File.dirname(__FILE__), 'credentials.yml'))
  end
  
  def read_real_credentials
    YAML.load_file(File.join(File.dirname(__FILE__), 'credentials.yml'))
  end
  
  def set_real_credentials
    if real_credentials_available?
      cfg = read_real_credentials.symbolize_keys!
      
      Loopiator.configure do |config|
        cfg.each do |key, value|
          config.send("#{key}=", value)
        end
      end
    end
  end
  
end