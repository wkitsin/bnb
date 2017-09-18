class ListingsController < ApplicationController

	def index 
		# byebug 
		@listing = [] 
		Listing.all.order("id ASC").each do |i|
			if i.user_id == current_user.id 
				@listing << i
			end 
		end 
		# byebug 

			
	end 

  def new
  	@listing = Listing.new 
  end
  
  def show
  	# byebug 
  	@listing = Listing.find(params[:id])
  end 

  def edit 
  	# byebug 
  	@listing = Listing.find(params[:id])
  end 

  def update 
  	id = params[:id]
  	location = params["listing"]["location"]
  	guest =params["listing"]["number_of_guest"]
  	price = params["listing"]["price"]
  	room = params["room"]
  	category = params["category"]

  	# byebug 

  	@listing = Listing.find(id).update(location: location, user_id: current_user.id, number_of_guest: guest , price:
  		price , category: category, type_of_room: room)

  	@update = "Your listing at #{location} has been updated"
  	redirect_to root_path 
  end 

  def create 
  	# byebug 
  	location = params["listing"]["location"]
  	guest =params["listing"]["number_of_guest"]
  	price = params["listing"]["price"]
  	category = params["category"]
  	@listing = Listing.new(location: location, user_id: current_user.id, number_of_guest: guest , price:
  		price , category: category)

  	if @listing.save 
  		redirect_to @listing 
  	else 
  		redirect_to new_listing_path 
  	end 
  end 
end
