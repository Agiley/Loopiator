require 'xmlrpc/client'
require 'simpleidn'

module Loopiator
  class Client
    attr_accessor :client
    
    include Loopiator::Logger
    
  	def initialize(connection_options = nil)
      set_client(connection_options)
  	end
  	
  	def set_client(connection_options = nil)
  	  self.client           =   XMLRPC::Client.new_from_hash(generate_connection_options(connection_options))
      self.client.instance_variable_get(:@http).instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
  	  self.client
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
        when :ok                then  return response
        when :domain_occupied   then  return response
        when :auth_error        then  raise Loopiator::AuthError
        when :rate_limited      then  raise Loopiator::RateLimitError
        when :bad_indata        then  raise Loopiator::InvalidParameterError
        when :unknown_error     then  raise Loopiator::UnknownError
        else
          return response
      end
  	end

  	include Loopiator::Domains
  	include Loopiator::Credits
    
    private
      def generate_connection_options(connection_options = nil)
        connection_options    ||=   {
          host:         Loopiator.configuration.host,
          path:         Loopiator.configuration.path,
          port:         Loopiator.configuration.port,
          use_ssl:      Loopiator.configuration.use_ssl,
          timeout:      Loopiator.configuration.timeout,
          proxy_host:   Loopiator.configuration.proxy_host,
          proxy_port:   Loopiator.configuration.proxy_port,
          user:         Loopiator.configuration.proxy_user,
          password:     Loopiator.configuration.proxy_password,
        }
      end
      
  end
end