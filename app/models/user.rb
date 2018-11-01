class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :comments, dependent: :restrict_with_error
  has_many :commented_articles, through: :comments, source: :article

  has_many :favorites, dependent: :destroy
  has_many :favorited_articles, through: :favorites, source: :article

  has_many :articles

  has_many :friendships, -> {where status: true}, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, -> {where status: true}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :not_yet_accepted_friendships, -> {where status: false}, class_name: "Friendship", dependent: :destroy
  has_many :not_yet_accepted_friends, through: :not_yet_accepted_friendships, source: :friend

  has_many :not_yet_responded_friendships, -> {where status: false}, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :not_yet_responded_friends, through: :not_yet_responded_friendships, source: :user

  def admin?
    self.role == "admin"
  end
  
  def following?(user)
    if (self.friendships.where(following_id: user.id).size > 0)
      return true
    else
      return false
    end
  end

  def friend?(user)
    self.friends.include?(user) || self.inverse_friends.include?(user)
  end

  def not_yet_accepted_friends?(user)
    self.not_yet_accepted_friends.include?(user)
  end

  def not_yet_responded_friends?(user)
    self.not_yet_responded_friends.include?(user)
  end
  
  def all_friends
    friends = self.friends + self.inverse_friends
    return friends.uniq
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

end
