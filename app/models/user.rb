# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :wins, class_name: 'Match', foreign_key: 'winner_id'
  has_many :losses, class_name: 'Match', foreign_key: 'loser_id'
  scope :ranked, -> { order('win_count / (win_count + loss_count) DESC') }
  scope :leaders, -> { ranked.limit(10) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true, length: { maximum: 50 }  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  before_save { self.email = email.downcase }  

  def win_percentage
    win_count.to_f / (win_count + loss_count)
  end

  def matches
    @matches ||= Match.played_by(id)
  end
end
