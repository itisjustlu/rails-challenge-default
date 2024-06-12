class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, length: { maximum: 200 }, uniqueness: true
  validates :phone_number, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :key, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :account_key, length: { maximum: 100 }, uniqueness: true
  validates :metadata, length: { maximum: 2000 }
end