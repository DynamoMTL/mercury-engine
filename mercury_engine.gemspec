$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mercury_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mercury_engine"
  s.version     = MercuryEngine::VERSION
  s.author      = "Josh Nussbaum"
  s.email       = "joshnuss@gmail.com"
  s.homepage    = "http://www.github.com/DynamoMTL/mercury-engine"
  s.summary     = "simple content management in an engine"
  s.description = "a mercury based mercury_engine, backed by active_admin"
  s.required_ruby_version = ">= 1.9.3"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "mercury-rails"
  s.add_dependency "activeadmin"
  s.add_dependency "acts_as_tree"
  s.add_dependency "paper_trail"
  s.add_dependency "has_permalink"
  s.add_dependency "haml-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "coffee-rails"

  s.add_development_dependency "sqlite3"
end
