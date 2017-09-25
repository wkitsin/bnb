class TypeOfRoomColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :type_of_room, :string 
  end
end
