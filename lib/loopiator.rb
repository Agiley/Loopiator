module Loopiator
  VERSION = "0.0.1"

  require File.join(File.dirname(__FILE__), 'loopiator/railtie') if defined?(Rails)

  require File.join(File.dirname(__FILE__), 'loopiator/logger')
  require File.join(File.dirname(__FILE__), 'loopiator/domains')

  require File.join(File.dirname(__FILE__), 'loopiator/client')
end

