class RoomsController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.where.not(id: current_user.id)
        
        user_rooms = []
        all_user_rooms = UserToRoom.where(user_id: current_user.id)
        all_user_rooms.each { |room| user_rooms << room.room_id }

        @rooms = Room.find(user_rooms)
    end

    def show
        @users = User.where.not(id: current_user.id)
        
        user_rooms = []
        all_user_rooms = UserToRoom.where(user_id: current_user.id)
        all_user_rooms.each { |room| user_rooms << room.room_id }

        @rooms = Room.find(user_rooms)

        @room = Room.find(params[:id])

        @messages = Message.where(room_id: params[:id])
    end

    def create
        room = Room.new
        room.name = ''
        room.last_message = 'Начните диалог'
        room.save

        user_to_room = UserToRoom.new
        user_to_room.user_id = current_user.id
        user_to_room.room_id = room.id

        invite_user = User.find(params[:user_id])
        invite_user_to_room = UserToRoom.new
        invite_user_to_room.user_id = invite_user.id
        invite_user_to_room.room_id = room.id

        user_to_room.save
        invite_user_to_room.save

        redirect_back(fallback_location: rooms_path)
    end

end
