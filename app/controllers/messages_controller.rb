class MessagesController < ApplicationController

    def create
        @room = Room.find(params[:room_id])
        @message = @room.messages.create(message_params)
        @message.room_id = @room.id
        @message.user_id = current_user.id

        @message.save

        redirect_back(fallback_location: rooms_path(params[:room_id]))
    end

    private

    def message_params
        params.require(:message).permit(:body)
    end

end
