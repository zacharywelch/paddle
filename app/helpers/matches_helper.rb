module MatchesHelper
  def win_loss_column(match, user)
    fill = match.won?(user) ? 'fill-green' : 'fill-red'
    content_tag :span, class: "pin-topleft #{fill} dark pad2y center" do
      concat match.won?(user) ? "W" : "L"
    end  
  end
end
