module MessagesHelper

    def display_massage_avatar message
        if message.avatar.present?
            image_tag(message.avatar, style: "width: 50px; height: 50px; object-fit: cover;", class: "user-avarat-style shadow")
        else
            image_tag("default_message_icon.png", size: "50x50", class: "user-avarat-style shadow")
        end
    end

end
