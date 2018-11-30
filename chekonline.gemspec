$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'chekonline/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'chekonline'
  s.version     = Chekonline::VERSION
  s.authors     = ['Alexey Gordienko']
  s.email       = ['alx@anadyr.org']
  s.homepage    = 'https://github.com/gordienko/chekonline'
  s.summary     = 'Simple chekonline client.'
  s.description = 'Ruby module for connecting to the online ticketing rental service for online stores, vending machines and entrepreneurs who make payments on the Internet, incl. upon receipt of payments to the company settlement account.'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails'
  s.add_dependency 'mechanize', '~> 2.7.5'
  s.add_development_dependency 'sqlite3'
end
