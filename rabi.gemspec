$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rabi/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name        = 'rabi'
	s.version     = Rabi::VERSION
	s.authors     = [ 'Alexander Senko' ]
	s.email       = [ 'Alexander.Senko@gmail.com' ]
	s.homepage    = 'https://github.com/softpro/rabi'
	s.summary     = 'Rails Application Building Itself.'
	s.description = 'Rails engine providing an interface for managing your DB schema, data and access control.'
	s.license     = 'MIT'

	s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

	s.add_dependency 'rails', '~> 4.0.0'

	s.add_dependency 'rails_dynamic_associations'
	s.add_dependency 'rails_admin'
	s.add_dependency 'passenger' # just for reloading

	s.add_development_dependency 'sqlite3'
end
