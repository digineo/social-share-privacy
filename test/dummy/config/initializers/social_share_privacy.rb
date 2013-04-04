SocialSharePrivacy.configure do |config|

  config.info_link = 'http://www.heise.de/ct/artikel/2-Klicks-fuer-mehr-Datenschutz-1333879.html'

  config.uri = Proc.new {|helper| helper.request.url}

  config.cookie do |cookie|
    cookie.path = '/'
    cookie.domain = Proc.new {|helper| helper.request.host}
    cookie.expires = 365
  end

  config.services do |services|

    services.facebook do |facebook|
      facebook.enabled = true
      facebook.perma_option = true
      facebook.referrer_track = ''
      facebook.language = Proc.new { I18n.locale }
    end

    services.twitter do |twitter|
      twitter.enabled = true
      twitter.perma_option = true
      twitter.referrer_track = ''
      twitter.language = Proc.new { I18n.locale }
    end

    services.gplus do |gplus|
      gplus.enabled = true
      gplus.perma_option = true
      gplus.referrer_track = ''
      gplus.language = Proc.new { I18n.locale }
    end
  
  end

end
