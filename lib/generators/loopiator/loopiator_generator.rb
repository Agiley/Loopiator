require 'generators/helpers/file_helper'

module Loopiator
  module Generators
    class LoopiatorGenerator < Rails::Generators::Base
      namespace "loopiator"
      source_root File.expand_path("../../templates", __FILE__)

      desc "Copies loopia.yml to the Rails app's config directory."

      def copy_config
        template "loopia.template.yml", "config/loopia.yml"
      end

    end
  end
end

