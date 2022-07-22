class MessagesController < ApplicationController

    before_action do
        ActiveStorage::Current.host = request.base_url
    end

    def create
        room = Room.find(params[:room_id])
        new_message = room.messages.create(body: message_params[:body], room_id: room.id, user_id: current_user.id)

        room.update(last_message: new_message.body)

        if new_message.save
            @new_message = new_message

            @new_message.name = current_user.username
            @new_message.avatar = current_user.avatar.url

            @new_message.broadcast_append_to @new_message.room

            @room = room
            @room.user_to_rooms.each do |user_to_room|
                if @room.room_status.to_i == 0
                    @room.name = current_user.username
                    @room.avatar = current_user.avatar.url
                end
                @room.broadcast_remove_to "rooms_#{user_to_room.user_id}".to_sym, target: "room_#{room.id}"
                @room.broadcast_prepend_to "rooms_#{user_to_room.user_id}".to_sym
            end
        end
    end

    private

    def message_params
        params.require(:message).permit(:body)
    end

end
