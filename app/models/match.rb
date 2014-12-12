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
  after_create :post_wins_losses

  private

  def post_wins_losses
    winner.increment_wins
    loser.increment_losses
    adjust_points
  end

  def adjust_points
    winner.calculate_statistics(winner.points, loser.points, winner.id)
    loser.calculate_statistics(loser.points, winner.points, winner.id)
  end
end
