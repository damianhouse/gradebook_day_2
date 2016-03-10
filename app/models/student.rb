class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :teacher
  has_many :parents, dependent: :destroy
  has_many :grades, dependent: :destroy

  validates :teacher, presence: true
  validates :email, uniqueness: true
end
