module SearchHelper

    def display_user_avatar_on_search user
        if user.avatar.present?
            image_tag(user.avatar.variant(resize_to_fill: [50, 50]), class: "user-avarat-style")
        else
            image_tag("default_user_avatar.png", size: "50x50", class: "user-avarat-style")
        end
    end

end
