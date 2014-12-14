module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def player_name(player)
    [player.first_name, nickname(player), player.last_name].compact.join(' ').html_safe
  end

  private

  def nickname(player)
    unless player.nickname.blank? 
      content_tag :span, player.nickname_in_quotes, class: 'quiet hidden-xs'
    end
  end  
end
