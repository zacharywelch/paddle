# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  winner_id  :integer
#  loser_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Match < ActiveRecord::Base
  belongs_to :winner, class_name: 'User', counter_cache: 'win_count'
  belongs_to :loser, class_name: 'User', counter_cache: 'loss_count'
  scope :played_by, ->(player_id) { where("winner_id = ? OR loser_id = ?", player_id, player_id) }
end
