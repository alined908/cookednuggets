class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :forum_threads
  has_many :posts
  has_many :matches
  validates :firstname, presence: true, length: {maximum: 20}
  validates :lastname, presence: true, length: {maximum: 20}
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 20}
  validates :country, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:normal, :moderator, :admin]

  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end

  def normal?
    role == "normal"
  end
end
