class User < ApplicationRecord
  has_person_name
  has_one_attached :avatar
  has_many :likes, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end