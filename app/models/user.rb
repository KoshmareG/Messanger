class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :room
  has_one :user_to_rooms, dependent: :destroy
  has_many :messages

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
            file_content_type: { allow: ['image/jpeg', 'image/png', 'image/webp'] }
end
