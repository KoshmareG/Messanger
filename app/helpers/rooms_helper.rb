module RoomsHelper

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
