class Room < ApplicationRecord

    attr_accessor :username, :avatar

    has_many :users
    has_many :user_to_rooms, dependent: :destroy
    has_many :messages, dependent: :destroy

    has_one_attached :image

    validates :image, file_size: { less_than_or_equal_to: 5.megabytes },
                file_content_type: { allow: ['image/jpeg', 'image/png', 'image/webp'] }

    default_scope { order(updated_at: :desc) }

end
