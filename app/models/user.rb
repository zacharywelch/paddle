# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  win_count       :integer          default(0)
#  loss_count      :integer          default(0)
#  first_name      :string(255)
#  last_name       :string(255)
#  nickname        :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  points          :integer          default(1000)
#

class User < ActiveRecord::Base
  has_many :wins, class_name: 'Match', foreign_key: 'winner_id'
  has_many :losses, class_name: 'Match', foreign_key: 'loser_id'
  scope :ranked, -> { order(points: :desc) }
  scope :leaders, -> { ranked.limit(10) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  DEFAULT_AVATARS = %w(batman.jpg adventuretime.jpg gumball.jpg fizzys-lunch-lab.png fusionfall.jpg wordgirl.png steven.jpg robin.jpg regularshow.jpg pokemon.jpg hero.jpg foster.jpg cyberchase.png ben10.jpg super-why.png)
  
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

  def name
    [first_name, last_name].compact.join(' ')
  end

  def matches
    @matches ||= Match.played_by(id).includes(:winner, :loser)
  end

  def won(loser)
    update_attributes win_count: win_count + 1, points: points + win_points(loser)
  end

  def lost(winner)
    update_attributes loss_count: loss_count + 1, points: points + loss_points(winner)
  end

  def nickname_in_quotes
    "\"" + nickname + "\"" unless nickname.blank?
  end

  def rank
    @rank ||= User.ranked.index(self) + 1
  end

  def avatar_url
    DEFAULT_AVATARS[(id - 1) % DEFAULT_AVATARS.length]
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def win_points(loser)
    calculate_points(loser, 1.0)
  end

  def loss_points(winner)
    calculate_points(winner, 0.0)
  end

  def calculate_points(other_player, win_factor)
    if self.points < 2100 or other_player.points < 2100
      k_factor = 32.0    
    elsif self.points < 2401 or other_player.points < 2401
      k_factor = 24.0
    else
      k_factor = 16.0
    end
    point_difference = self.points - other_player.points
    power_of = 10.0**(-point_difference / 400.0)
    denominator = power_of + 1.0
    k_factor * (win_factor - (1 / denominator))
  end
end
