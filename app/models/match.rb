# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  winner_id  :integer
#  loser_id   :integer
#  created_at :datetime
#  updated_at :datetime


class Match < ActiveRecord::Base
  belongs_to :winner, class_name: 'User'
  belongs_to :loser, class_name: 'User'
  scope :played_by, ->(player_id) { where("winner_id = ? OR loser_id = ?", player_id, player_id) }
  scope :recent, -> { order(created_at: :desc) }
  after_create :post_wins_losses

  def won?(player)
    player == winner
  end

  def lost?(player)
    player == loser
  end

  def opponent(player)
    winner == player ? loser : winner 
  end

  private

  def post_wins_losses
    winner.won(loser)
    loser.lost(winner)
  end
end
