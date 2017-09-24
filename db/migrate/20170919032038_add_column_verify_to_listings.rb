class AddColumnVerifyToListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :verify, :boolean, :default => false 
  end
end
