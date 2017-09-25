class CreateListing < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.belongs_to :user 
    	t.string :location 
    	t.integer :number_of_guest 
    	t.integer :price 
    	t.string :category 
    end
  end
end
