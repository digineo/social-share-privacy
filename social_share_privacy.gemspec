$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "social_share_privacy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social_share_privacy"
  s.version     = SocialSharePrivacy::VERSION
  s.authors     = ["Joakim Reinert"]
  s.email       = ["mail@jreinert.com"]
  s.homepage    = "https://github.com/supasnashbuhl/social-share-privacy"
  s.summary     = "Adds the heise social share privacy plugin to the asset pipeline"
  s.description = "Provides the heise socialshareprivacy plugin for the rails asset pipeline. This lets you add the so-called Heise two click social buttons to your app for more privacy"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1"

  s.add_development_dependency "sqlite3"
end
