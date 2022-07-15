class ProfilesController < ApplicationController

    def find_users_rooms user
        user_rooms = []
        UserToRoom.where(user_id: user.id).each { |room| user_rooms << room.room_id }
        return user_rooms
    end

    def show
        @user = User.find(params[:id])
        
        current_user_rooms = find_users_rooms(current_user)
        user_rooms = find_users_rooms(@user)

        common_rooms_id = current_user_rooms & user_rooms
        @privat_room = Room.where(id: common_rooms_id, room_status: 0)[0]

        @common_rooms = Room.where(id: common_rooms_id, room_status: 1)
        @conv_rooms = Room.where(id: current_user_rooms, room_status: 1).where.not(id: common_rooms_id)
    end

end
