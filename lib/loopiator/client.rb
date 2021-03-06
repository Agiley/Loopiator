require 'xmlrpc/client'
require File.join(File.dirname(__FILE__), 'patch') # Needed to convert <i4> to <int> - Loopia's XML RPC server won't accept <i4> as a valid method signature
require 'simpleidn'

module Loopiator
  class Client
    attr_accessor :client
    
    include Loopiator::Logger
    
  	def initialize(connection_options = {})
      connection_options.symbolize_keys!
      set_client(connection_options)
  	end
  	
  	def set_client(connection_options = {})
  	  self.client         =   XMLRPC::Client.new_from_hash(generate_connection_options(connection_options))
      enable_debugging if Loopiator.configuration.debug
      set_client_options(connection_options)
  	end
  	
  	def call(rpc_method, *args)
  	  response    =   nil
  	  
  	  begin
        response  =   self.client.call(rpc_method, Loopiator.configuration.username, Loopiator.configuration.password, *args)
        
      rescue EOFError => eof_error
        raise Loopiator::ConnectionError
      end
      
      return response
  	end
  	
  	def parse_status_response(response)
  	  response    =   response.downcase.to_sym
  	  
  	  case response
        when :ok                  then  return response
        when :domain_occupied     then  return response
        when :auth_error          then  raise Loopiator::AuthError
        when :rate_limited        then  raise Loopiator::RateLimitError
        when :insufficient_funds  then  raise Loopiator::InsufficientFundsError
        when :bad_indata          then  raise Loopiator::InvalidParameterError
        # :unknown_error will be returned when calling 'orderDomain' and the domain already exists in a customer account
        # do not raise an error until Loopia has updated their API to add an additional error code specifically targeting this phenomena
        #when :unknown_error       then  raise Loopiator::UnknownError
        else
          return response
      end
  	end

  	include Loopiator::Domains
    include Loopiator::Dns
  	include Loopiator::Credits
    
    private
      def generate_connection_options(connection_options = {})
        default_options = {
          host:             determine_host(connection_options),
          path:             Loopiator.configuration.path,
          port:             Loopiator.configuration.port,
          
          user:             Loopiator.configuration.auth_user,
          password:         Loopiator.configuration.auth_password,
          
          use_ssl:          Loopiator.configuration.use_ssl,
          timeout:          Loopiator.configuration.timeout,
          
          proxy_host:       Loopiator.configuration.proxy_host,
          proxy_port:       Loopiator.configuration.proxy_port,
          proxy_user:       Loopiator.configuration.proxy_user,
          proxy_password:   Loopiator.configuration.proxy_password,
        }
        
        default_options.merge(connection_options)
      end
      
      def determine_host(connection_options = {})
        env   =   (connection_options && !connection_options.empty?) ? connection_options.fetch(:environment, Loopiator.configuration.environment) : Loopiator.configuration.environment
        Loopiator.configuration.hosts[env.to_sym]
      end
      
      def enable_debugging
        self.client.instance_variable_get(:@http).set_debug_output($stderr)
      end
      
      def set_client_options(connection_options = {})
        self.client.instance_variable_get(:@http).instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
        
        #Seems to be the only way to set the proxy user / password for Ruby's XMLRPC?
        proxy_user          =   connection_options.fetch(:proxy_user, nil)
        proxy_password      =   connection_options.fetch(:proxy_password, nil)
        self.client.instance_variable_get(:@http).instance_variable_set(:@proxy_user, proxy_user)     if (proxy_user && !proxy_user.empty?)
        self.client.instance_variable_get(:@http).instance_variable_set(:@proxy_pass, proxy_password) if (proxy_password && !proxy_password.empty?)
      end
      
  end
end
