class Room < ApplicationRecord

    has_many :users
    has_many :user_to_rooms, dependent: :delete_all
    has_many :messages, dependent: :delete_all

    has_one_attached :image

    validates :image, file_size: { less_than_or_equal_to: 5.megabytes },
                file_content_type: { allow: ['image/jpeg', 'image/png', 'image/webp'] }

end
