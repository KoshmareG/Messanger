module RoomsHelper

    def add_additional_info_to_rooms user_rooms
        user_rooms.each do |room|
            if room.room_status == 0
                user_to_room = UserToRoom.where(room_id: room.id)
                user_to_room.each do |user_room|
                    unless user_room.user_id == current_user.id
                    user = User.find(user_room.user_id)
                    room.username = user.username
                    room.avatar = user.avatar.url
                    end
                end
            end
        end
    end

    def display_room_avatar room
        if room.room_status == 0
            if room.avatar.present?
                image_tag(room.avatar, size: "60x60", class: "user-avarat-style")
            else
                image_tag("default_message_icon.png", size: "60x60", class: "user-avarat-style")
            end
        else
            if room.image.present?
            else
                image_tag("default_message_icon.png", size: "60x60", class: "user-avarat-style")
            end
        end
    end

    def display_room_name room
        if room.room_status == 0
            room.username
        else
            room.name
        end
    end
end
