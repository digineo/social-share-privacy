module SocialSharePrivacy
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_locales
        copy_file "en_social_share_privacy.yml", "config/locales/en_social_share_privacy.yml"
        copy_file "de_social_share_privacy.yml", "config/locales/de_social_share_privacy.yml"
      end

      def copy_initializer
        copy_file "social_share_privacy.rb", "config/initializers/social_share_privacy.rb"
      end
    end
  end
end
