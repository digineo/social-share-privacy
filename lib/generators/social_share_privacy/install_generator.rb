module SocialSharePrivacy
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        copy_file "social_share_privacy.rb", "config/initializers/social_share_privacy.rb"
      end
    end
  end
end
