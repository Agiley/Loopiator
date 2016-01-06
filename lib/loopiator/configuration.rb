module Loopiator
  class Configuration
    attr_accessor :environment
    attr_accessor :hosts, :port, :path
    attr_accessor :auth_user, :auth_password
    attr_accessor :use_ssl, :timeout
    attr_accessor :debug
    attr_accessor :username, :password
    attr_accessor :proxy_host, :proxy_port, :proxy_user, :proxy_password
    
    def initialize
      self.environment      =   :production
      
      self.hosts            =   {
        production: "api.loopia.se",
        test:       "test-api.loopia.se"
      }
      
      self.port             =   443
      self.path             =   "/RPCSERV"
      
      self.auth_user        =   nil
      self.auth_password    =   nil
      
      self.use_ssl          =   true
      self.timeout          =   180
      
      self.debug            =   false
      
      self.username         =   nil
      self.password         =   nil
      
      self.proxy_host       =   nil
      self.proxy_port       =   nil
      self.proxy_user       =   nil
      self.proxy_password   =   nil
    end
        
  end
end