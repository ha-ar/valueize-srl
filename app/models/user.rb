class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :name, :role, presence: true
  has_many :companies, dependent: :destroy
  has_one_attached :photo

  enum role: {
    student: 'student',
    teacher: 'teacher'
  }

  def student?
  	role == "student"
  end
end
