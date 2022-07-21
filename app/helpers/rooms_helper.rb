module RoomsHelper

    def add_additional_info_to_rooms_show room
        users_to_room = UserToRoom.where(room_id: room.id)

        if room.room_status == 0
            users_to_room.each do |user_to_room|
                unless user_to_room.user_id == current_user.id
                    @user = User.find(user_to_room.user_id)
                end
            end
            room.name = @user.username
            room.avatar = @user.avatar.url
        end
    end

    def add_additional_info_to_messages messages
        users_id = []
        messages.each { |message| users_id << message.user_id }
        users_id.uniq!

        users = []
        users_id.each { |user_id| users << User.find(user_id) }

        messages.each do |message|
            users.each do |user|
                if message.user_id == user.id
                    message.name = user.username
                    message.avatar = user.avatar.url
                end
            end
        end
    end

    def add_additional_info_to_rooms_index user_rooms
        user_rooms.each do |room|
            if room.room_status == 0
                user_to_room = UserToRoom.where(room_id: room.id)
                user_to_room.each do |user_room|
                    unless user_room.user_id == current_user.id
                    user = User.find(user_room.user_id)
                    room.name = user.username
                    room.avatar = user.avatar.url
                    end
                end
            end
        end
    end

    def display_room_avatar room, code

        size_arr = [60, 40]

        if room.room_status == 0
            if room.avatar.present?
                image_tag(room.avatar, style: "width: #{size_arr[code]}px; height: #{size_arr[code]}px; object-fit: cover;", class: "user-avarat-style")
            else
                image_tag("default_user_avatar.png", size: "#{size_arr[code]}x#{size_arr[code]}", class: "user-avarat-style")
            end
        else
            if room.image.present?
                image_tag(room.image, style: "width: #{size_arr[code]}px; height: #{size_arr[code]}px; object-fit: cover;", class: "user-avarat-style")
            else
                image_tag("default_message_icon.png", size: "#{size_arr[code]}x#{size_arr[code]}", class: "user-avarat-style")
            end
        end
    end

end
