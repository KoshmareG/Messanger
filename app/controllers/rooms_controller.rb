class RoomsController < ApplicationController
    before_action :authenticate_user!

    before_action do
        ActiveStorage::Current.host = request.base_url
    end

    def index
        all_user_rooms = []
        user_rooms = UserToRoom.where(user_id: current_user.id)
        user_rooms.each { |room| all_user_rooms << room.room_id }

        @rooms = Room.where(id: all_user_rooms)

        helpers.add_additional_info_to_rooms_index @rooms
    end

    def show
        @room = Room.find(params[:id])

        helpers.add_additional_info_to_rooms_show @room

        @messages = Message.where(room_id: params[:id])
    end

    def create
        #Room_status specifies what room type need to create
        #Room_status 0 - create new private room; 1 - create new common room; 2 - add new user to common room
        
        if params[:room_status].present? && (params[:room_status].to_i == 0 or params[:room_status].to_i == 1)

            #Protection against re-creating a private room
            if params[:room_status].to_i == 0
                user_to_rooms = []
                UserToRoom.where(user_id: current_user.id).each { |user_to_room| user_to_rooms << user_to_room.room_id }

                invite_user_to_rooms = []
                UserToRoom.where(user_id: params[:user_id]).each { |invite_user_to_room| invite_user_to_rooms << invite_user_to_room.room_id }
                
                rooms_id = user_to_rooms & invite_user_to_rooms

                rooms = Room.where(id: rooms_id)

                rooms.each do |room|
                    if room.room_status == 0
                        redirect_to room_path(room)
                        return
                    end
                end
            end
               
            #create new room private or common room
            invite_user = User.find(params[:user_id])

            if params[:room_status].to_i == 0
                room_name = 'privat_room_username'
            elsif params[:room_status].to_i == 1
                room_name = 'Новая беседа'
            end

            room = Room.create(last_message: 'Сообщений пока нет', room_status: params[:room_status].to_i, name: room_name)

            room.user_to_rooms.create(user_id: invite_user.id)
            room.user_to_rooms.create(user_id: current_user.id)

            if room.save
                if params[:room_status].to_i == 0
                    @room = room
                    @room.name = current_user.username
                    @room.avatar = current_user.avatar.url
                    @room.broadcast_prepend_to "rooms_#{invite_user.id}".to_sym
                end
            end

        elsif params[:room_status].present? && params[:room_status].to_i == 2

            #add new user to common room
            room = Room.find(params[:room_id])
            invite_user = User.find(params[:user_id])

            room.user_to_rooms.create(user_id: invite_user.id)
        end

        redirect_to room_path(room)
    end

    def update
        @room = Room.find(params[:id])

        @room.update(room_params)

        redirect_back(fallback_location: root_path)
    end

    private

    def room_params
        params.require(:room).permit(:image, :name)
    end

    private

end
