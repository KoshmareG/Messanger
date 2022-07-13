class AddSpecsForUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end
