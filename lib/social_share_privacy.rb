class Object
  def deep_clone
    begin
      result = self.clone
      self.instance_variables.each do |var_name|
        var = self.instance_variable_get var_name
        result.instance_variable_set var_name, var.deep_clone 
      end
      result
    rescue TypeError
      self
    end
  end
end

module SocialSharePrivacy
  module Generators
  end
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  %w{ models controllers helpers }.each do |dir|
    path = File.join(File.dirname(__FILE__), 'app', dir)
    $LOAD_PATH << path
    ActiveSupport::Dependencies.autoload_paths << path
    ActiveSupport::Dependencies.autoload_once_paths.delete(path)
  end

  module Evaluatable

    def eval request
      result = self.deep_clone
      result.instance_variables.each do |var_name|
        var = result.instance_variable_get var_name
        if var.is_a? Proc
          result.instance_variable_set var_name, var.call(request)
        elsif var.is_a? Evaluatable
          result.instance_variable_set var_name, var.eval(request)
        end
      end
      result
    end

  end

  module JSONable

    def to_s
      json_string = '{'
      vars = self.instance_variables.map do |var_name|
        var = self.instance_variable_get var_name
        var_s = var.to_s
        unless var.is_a? JSONable
          var_s = '"' + var_s.gsub(/(["\\])/){ "\\" + $1 } + '"'
        end
        "\"#{var_name.to_s.sub(/^@+/,'').downcase}\":#{var_s}"
      end
      json_string += vars.join(',')
      json_string + '}'
    end
  end
        
  class Config

    include Evaluatable, JSONable

    attr_accessor :info_link, :uri

    class Cookie

      include Evaluatable, JSONable
      attr_accessor :path, :domain, :expires
    end

    class Services

      include Evaluatable, JSONable

      class Service

        extend ActionView::Helpers::AssetTagHelper

        include Evaluatable, JSONable

        attr_accessor :referrer_track, :language
        attr_reader :status, :perma_option

        def initialize
          loc_s = 'social_share_privacy.' + self.class.name.downcase
          @txt_info = Proc.new { I18n.t("#{loc_s}.txt_info") }
          @txt_help = Proc.new { I18n.t("#{loc_s}.txt_help") }
          @txt_off = Proc.new { I18n.t("#{loc_s}.txt_off") }
          @txt_on = Proc.new { I18n.t("#{loc_s}.txt_on") }
          @display_name = Proc.new { I18n.t("#{loc_s}.display_name") }
          @dummy_button = Proc.new { helper.asset_path('social_share_privacy/dummy_' + self.class.name.downcase + '.png')}
        end
        
        def enabled= value 
          if value 
            @status = 'on'
          else
            @status = 'off'
          end
        end

        def perma_option= value
          if value
            @perma_option = 'on'
          else
            @perma_option = 'off'
          end
        end
      end

      class Facebook < Service
        attr_accessor :action

        def eval request
          result = super request
          result.dummy_button = helper.asset_path('social_share_privacy/dummy_facebook_de.png') if result.language == 'de'
          result
        end

      end

      class Twitter < Service
      end

      class Gplus < Service
      end

      def facebook
        yield(@facebook ||= Facebook.new)
      end
      
      def twitter
        yield(@twitter ||= Twitter.new)
      end

      def gplus
        yield(@gplus ||= Twitter.new)
      end
    end

    def initialize
      @txt_help = Proc.new { I18n.t('social_share_privacy.txt_help') }
      @txt_perma = Proc.new { I18n.t('social_share_privacy.txt_perma') }
    end

    def cookie
      yield(@cookie ||= Cookie.new)
    end

    def services
      yield(@services ||= Services.new)
    end
    
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield(config)
  end

end
