class AddReservationsTable < ActiveRecord::Migration[5.0]
  def change
  create_table :reservations do |t|
     	t.belongs_to :user 
     	t.belongs_to :listing 

     end
  end
end
