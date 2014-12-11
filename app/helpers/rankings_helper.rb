module RankingsHelper
  def player_name(player)
    [player.first_name, nickname(player), player.last_name].compact.join(' ').html_safe
  end

  private

  def nickname(player)
    unless player.nickname.blank? 
      content_tag :span, player.nickname_in_quotes, class: 'quiet'
    end
  end
end
