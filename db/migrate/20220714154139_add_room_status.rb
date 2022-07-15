class AddRoomStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :room_status, :integer
  end
end
