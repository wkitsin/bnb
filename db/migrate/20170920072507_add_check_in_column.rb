class AddCheckInColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :check_in, :string 
  	add_column :reservations, :check_out, :string
  	add_column :reservations, :paid_statusm, :boolean, :default => false 
  end
end
