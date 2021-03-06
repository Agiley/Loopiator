require File.join(File.dirname(__FILE__), 'loopiator/railtie') if defined? Rails
require File.join(File.dirname(__FILE__), 'loopiator/extensions/hash') if !Hash.instance_methods(false).include?(:symbolize_keys!)
require File.join(File.dirname(__FILE__), 'loopiator/configuration')
require File.join(File.dirname(__FILE__), 'loopiator/logger')
require File.join(File.dirname(__FILE__), 'loopiator/errors')
require File.join(File.dirname(__FILE__), 'loopiator/utilities')
require File.join(File.dirname(__FILE__), 'loopiator/models/domain')
require File.join(File.dirname(__FILE__), 'loopiator/models/dns_record')
require File.join(File.dirname(__FILE__), 'loopiator/domains')
require File.join(File.dirname(__FILE__), 'loopiator/dns')
require File.join(File.dirname(__FILE__), 'loopiator/credits')
require File.join(File.dirname(__FILE__), 'loopiator/client')

module Loopiator
  VERSION     =   "0.4.2"
  
  class << self
    attr_writer :configuration
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.reset
    @configuration = nil
  end
  
  def self.configure
    yield(configuration)
  end
  
end
