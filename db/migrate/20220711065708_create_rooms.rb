class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name,         null: false, default: ""
      t.string :last_message, null: false, default: ""
      t.string :room_image

      t.timestamps
    end
  end
end
