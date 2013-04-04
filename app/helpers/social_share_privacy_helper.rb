module SocialSharePrivacyHelper

  def social_buttons
    options = social_share_privacy_config.to_s
    result = []
    result << '<div class="social_buttons"></div>'
    result << javascript_tag("jQuery(document).ready(function($) { $('.social_buttons').socialSharePrivacy(#{options}) });")
    raw(result.join("\n"))
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
