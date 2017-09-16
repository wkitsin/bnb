class ListingsController < ApplicationController
  def new
  	@listing = Listing.new 
  end
  
  def show
  end 

  def create 
  	byebug 
  	location = params["listing"]["location"]
  	guest =params["listing"]["number_of_guest"]
  	price = params["listing"]["price"]
  	category = params["listing"]["category"]
  	@listing = Listing.new(location: location, user_id: current_user.id, number_of_guest: guest.to_i , price:
  		price.to_i , category: category)

  	if @listing.save 
  		redirect_to @listing 
  	else 
  		redirect_to new_listing_path 
  	end 
  end 
end
