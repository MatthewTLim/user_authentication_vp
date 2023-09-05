class User <ApplicationRecord
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :username, uniqueness: true, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_secure_password
end