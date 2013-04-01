module SocialSharePrivacyHelper
  def social_buttons
    binding.pry
    options = SocialSharePrivacy.config.eval(request).to_s
    result = []
    result << '<div class="social_buttons"></div>'
    result << javascript_tag("jQuery(document).ready(function($) { $('.social_buttons').socialSharePrivacy(#{options}) });")
    raw(result.join("\n"))
  end
end
