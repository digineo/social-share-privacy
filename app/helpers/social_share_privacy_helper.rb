module SocialSharePrivacyHelper

  def social_buttons
    content_tag :div, '', class: 'social-buttons'
  end
  
  def social_share_privacy_config
    if @social_share_privacy_config.nil? ||
      @last_request != request
      @social_share_privacy = SocialSharePrivacy.config.eval(self)
      @last_request = request
    end
    @social_share_privacy
  end
end
