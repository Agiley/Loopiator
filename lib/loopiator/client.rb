require 'uri'
require 'cgi'
require 'rubygems'
require 'xmlrpc/client'
require 'simpleidn'

module Loopiator
  class Client
    attr_accessor :config, :client, :username, :password, :endpoint

  	def initialize(username = nil, password = nil, endpoint = nil)
  		@config       =   nil
  		set_config
      
  		@username     =   username   ||  @config.fetch("username", nil)
  		@password     =   password   ||  @config.fetch("password", nil)
  		@endpoint     =   endpoint   ||  @config.fetch("endpoint", nil)
  		
  		set_client
  	end

  	def set_config
  	  rails_env     =   defined?(Rails) ? Rails.env : "development"
  	  @config     ||=   YAML.load_file(File.join(Rails.root, "config/loopia.yml"))[rails_env] if defined?(Rails)
      @config     ||=   YAML.load_file(File.join(File.dirname(__FILE__), "../generators/templates/loopia.yml"))[rails_env] rescue nil
      @config     ||=   YAML.load_file(File.join(File.dirname(__FILE__), "../generators/templates/loopia.template.yml"))[rails_env] rescue nil
      @config     ||=   {}
  	end
  	
  	def set_client
  	  @client = XMLRPC::Client.new_from_uri(@endpoint)
  	  @client.instance_variable_get(:@http).instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
  	  @client
  	end
  	
  	def call(rpc_method, *args)
  	  @client.call(rpc_method, @username, @password, *args)
  	end
  	
  	include Loopiator::Logger
  	include Loopiator::Domains
  end
end

