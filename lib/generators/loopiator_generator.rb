require 'rails/generators'
require 'rails/generators/named_base'

module Loopiator
  module Generators
    class LoopiatorGenerator < ::Rails::Generators::Base
      argument :username, :type => :string, :banner => 'username', :default => nil
      argument :password, :type => :string, :banner => 'password', :default => nil
      
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      
      def create_initializer
        say "creating initializer..."
        
        if loopiator_already_configured?
          say "It looks like you've already configured Loopiator."
          say "To re-create the config file, remove it first: config/initializers/loopiator.rb"
          exit
        end
        
        template 'initializer.rb', 'config/initializers/loopiator.rb', assigns: { username: "'#{username}'", password: "'#{password}'" }
      end
      
      def loopiator_already_configured?
        File.exists?('config/initializers/loopiator.rb')
      end

    end
  end
end

