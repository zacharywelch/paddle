# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  email          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  win_count      :integer          default(0)
#  loss_count     :integer          default(0)
#  win_percentage :float
#  first_name     :string(255)
#  last_name      :string(255)
#  nickname       :string(255)
#

class User < ActiveRecord::Base
  has_many :wins, class_name: 'Match', foreign_key: 'winner_id'
  has_many :losses, class_name: 'Match', foreign_key: 'loser_id'
  scope :ranked, -> { order(points: :desc) }
  scope :leaders, -> { ranked.limit(10) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :first_name, presence: true, length: { maximum: 50 }  
  validates :last_name, presence: true, length: { maximum: 50 }  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  before_save { self.email = email.downcase }  
  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def full_name
    [first_name, nickname_in_quotes, last_name].compact.join(' ')
  end  

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

  def nickname_in_quotes
    "\"" + nickname + "\"" unless nickname.blank?
  end

  def rank
    User.order(points: :desc).index(self)+1
  end

  def calculate_statistics(pts, competitor_pts, winner_id)
    s = winner_id == id ? 1.0 : 0.0
    d = pts - competitor_pts
    f = 400.0
    if pts < 2100 or competitor_pts < 2100
      k = 32.0    
    elsif pts < 2401 or competitor_pts < 2401
      k = 24.0 
    else
      k = 16.0
    end
    power_of = 10.0**(-d/f)
    denominator = power_of + 1.0
    dE = k*(s-(1/denominator))
    update_attributes(points: points+dE)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
