Gem::Specification.new do |s|
  s.specification_version     = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=

  s.name = 'loopiator'
  s.version = '0.2.0'

  s.homepage      =   "https://github.com/Agiley/Loopiator"
  s.email         =   "sebastian@agiley.se"
  s.authors       =   ["Sebastian Johnsson"]
  s.description   =   "Interface for communicating with Loopia's API"
  s.summary       =   "Interface for communicating with Loopia's API"

  s.add_dependency 'simpleidn', '>= 0.0.4'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  # = MANIFEST =
 s.files = %w[
 Gemfile
 README.md
 Rakefile
 lib/generators/loopiator_generator.rb
 lib/generators/templates/initializer.rb
 lib/loopiator.rb
 lib/loopiator/client.rb
 lib/loopiator/configuration.rb
 lib/loopiator/credits.rb
 lib/loopiator/domains.rb
 lib/loopiator/errors.rb
 lib/loopiator/extensions/hash.rb
 lib/loopiator/logger.rb
 lib/loopiator/models/domain.rb
 lib/loopiator/railtie.rb
 lib/loopiator/utilities.rb
 loopiator.gemspec
 spec/loopiator/configuration_spec.rb
 spec/loopiator/credits_spec.rb
 spec/loopiator/domains_spec.rb
 spec/spec_helper.rb
 spec/support/helpers.rb
 ]
 # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ %r{^spec/*/.+\.rb} }
end