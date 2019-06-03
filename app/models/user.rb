class User < ActiveRecord::Base
  has_many :matches
  before_save {self.email = email.downcase}
  validates :firstname, presence: true, length: {maximum: 20}
  validates :lastname, presence: true, length: {maximum: 20}
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 100}, format: {with: VALID_EMAIL_REGEX}
  has_secure_password
  validates :password, presence: true, length: {minimum: 5}
end
