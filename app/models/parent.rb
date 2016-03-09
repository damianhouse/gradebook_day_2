class Parent < ActiveRecord::Base
  belongs_to :student

  has_secure_password

  validates :student, presence: true
  validates :email, uniqueness: true
end
