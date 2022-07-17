class MessagesController < ApplicationController

    before_action do
        ActiveStorage::Current.host = request.base_url
    end

    def create
        @room = Room.find(params[:room_id])
        @new_message = @room.messages.create(message_params)
        @new_message.room_id = @room.id
        @new_message.user_id = current_user.id
        @room.last_message = @new_message.body
        
        @room.save
        @new_message.save

        @new_message.name = current_user.username
        @new_message.avatar = current_user.avatar.url

        room = @new_message.room
        @new_message.broadcast_append_to @new_message.room
    end

    private

    def message_params
        params.require(:message).permit(:body)
    end

end
