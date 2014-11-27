# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  email          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  win_count      :integer          default(0)
#  loss_count     :integer          default(0)
#  win_percentage :float
#

class User < ActiveRecord::Base
  has_many :wins, class_name: 'Match', foreign_key: 'winner_id'
  has_many :losses, class_name: 'Match', foreign_key: 'loser_id'
  scope :ranked, -> { order(win_percentage: :desc) }
  scope :leaders, -> { ranked.limit(10) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true, length: { maximum: 50 }  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  before_save { self.email = email.downcase }  
  before_save :calculate_statistics, :if => :win_loss_changed?

  def matches
    @matches ||= Match.played_by(id)
  end

  def increment_wins
    update_attributes(win_count: win_count + 1)
  end

  def increment_losses
    update_attributes(loss_count: loss_count + 1)
  end

  def win_loss_changed?
    win_count_changed? || loss_count_changed?
  end

  def win!(other_user)
    wins.create!(loser: other_user)
  end

  def lose!(other_user)
    losses.create!(winner: other_user)
  end

  private

  def calculate_statistics
    self.win_percentage = win_count.to_f / (win_count + loss_count)
  end  
end
