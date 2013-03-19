$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cms"
  s.version     = Cms::VERSION
  s.author      = "Josh Nussbaum"
  s.email       = "joshnuss@gmail.com"
  s.homepage    = "http://www.github.com/DynamoMTL/cms"
  s.summary     = "simple content management"
  s.description = "a mercury based cms, backed by active_admin"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "fuubar"
end
