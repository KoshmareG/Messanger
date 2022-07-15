class RoomsController < ApplicationController
    before_action :authenticate_user!

    def create_user_to_room user, room
        user_to_room = UserToRoom.new
        user_to_room.user_id = user.id
        user_to_room.room_id = room.id

        return user_to_room
    end

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
        #Room_status specifies what room type need to create
        #Room_status 0 - create new private room; 1 - create new common room; 2 - add new user to common room
        
        if params[:room_status].present? && (params[:room_status].to_i == 0 or params[:room_status].to_i == 1)

            room = Room.new
            invite_user = User.find(params[:user_id])

            if params[:room_status].to_i == 0
                room.name = 'privat_room_username'
            elsif params[:room_status].to_i == 1
                room.name = 'Новая беседа'
            end

            room.last_message = 'Сообщений пока нет'
            room.room_status = params[:room_status].to_i
            room.save

            user_to_room = create_user_to_room(current_user, room)

            invite_user_to_room = create_user_to_room(invite_user, room)

            user_to_room.save
            invite_user_to_room.save

        elsif params[:room_status].present? && params[:room_status].to_i == 2

            room = Room.find(params[:room_id])
            invite_user = User.find(params[:user_id])

            invite_user_to_room = create_user_to_room(invite_user, room)

            invite_user_to_room.save

        end

        redirect_to room_path(room)
    end

end
