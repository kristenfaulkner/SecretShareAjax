# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  session_token   :string(255)      not null
#

class User < ActiveRecord::Base
  attr_reader :password

  has_many :authored_secrets, class_name: "Secret", foreign_key: :author_id
  has_many :received_secrets, class_name: "Secret", foreign_key: :recipient_id

  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, :username, presence: true

  after_initialize :ensure_session_token
  
  has_many(
    :owned_friendships,
    class_name: "Friendship",
    primary_key: :id,
    foreign_key: :in_friend_id
  )
  
  has_many(
    :admirer_friendships,
    class_name: "Friendship",
    primary_key: :id,
    foreign_key: :out_friend_id 
  )
  
  has_many(
    :owned_friends,
    through: :owned_friendships,
    source: :owned_friend
  )
  
  has_many(
    :admirers,
    through: :admirer_friendships,
    source: :friend_owner
  )
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def can_friend?(user)
    !(self.owned_friends.include?(user) || self.id == user.id) 
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
