module Helpers
  def real_credentials_available?
    File.exists?(File.join(File.dirname(__FILE__), 'credentials.yml'))
  end
end