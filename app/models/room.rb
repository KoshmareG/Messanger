class Room < ApplicationRecord

    has_many :users
    has_many :user_to_rooms, dependent: :delete_all
    has_many :messages, dependent: :delete_all

end
