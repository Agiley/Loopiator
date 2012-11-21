require 'uri'
require 'cgi'
require 'rubygems'
require 'xmlrpc/client'
require 'simpleidn'

module Loopiator
  class Client
    attr_accessor :config, :client, :username, :password, :endpoint

  	def initialize(options = {})
  		@config       =   set_config
      
      options.symbolize_keys!
      @config.merge!(options)
      
  		@username     =   @config.fetch(:username, nil)
  		@password     =   @config.fetch(:password, nil)
  		@endpoint     =   @config.fetch(:endpoint, nil)
  		
  		timeout       =   options.fetch(:timeout, 500)
  		
  		set_client(timeout)
  	end

  	def set_config
  	  rails_env     =   defined?(Rails) ? Rails.env : "development"
  	  config      ||=   YAML.load_file(File.join(Rails.root, "config/loopia.yml"))[rails_env] if defined?(Rails)
      config      ||=   YAML.load_file(File.join(File.dirname(__FILE__), "../generators/templates/loopia.yml"))[rails_env] rescue nil
      config      ||=   YAML.load_file(File.join(File.dirname(__FILE__), "../generators/templates/loopia.template.yml"))[rails_env] rescue nil
      config      ||=   {}
      
      config.symbolize_keys!
      
      return config
  	end
  	
  	def set_client(timeout = 500)
  	  @client = XMLRPC::Client.new_from_uri(@endpoint)
  	  @client.instance_variable_get(:@http).instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
  	  @client.timeout = timeout
  	  @client
  	end
  	
  	def call(rpc_method, *args)
  	  @client.call(rpc_method, @username, @password, *args)
  	end
  	
  	include Loopiator::Logger
  	include Loopiator::Domains
  end
end

