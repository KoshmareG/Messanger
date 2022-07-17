class RoomsController < ApplicationController
    before_action :authenticate_user!

    before_action do
        ActiveStorage::Current.host = request.base_url
    end

    def create_user_to_room user, room
        user_to_room = UserToRoom.new
        user_to_room.user_id = user.id
        user_to_room.room_id = room.id

        return user_to_room
    end

    def index
        all_user_rooms = []
        user_rooms = UserToRoom.where(user_id: current_user.id)
        user_rooms.each { |room| all_user_rooms << room.room_id }

        @user_rooms = Room.where(id: all_user_rooms)
    end

    def show
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
