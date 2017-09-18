class ListingsController < ApplicationController

	def index 
		# byebug 
		@listing = [] 
		@host = [] 
		Listing.all.order("id ASC").each do |i|
			if i.user_id == current_user.id 
				@listing << i
				@host << User.find(i.user_id).name
			end 
		end 

		@merge = @listing.zip(@host)
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
  	title = params["listing"]["title"].downcase
  	location = params["listing"]["location"]
  	guest =params["listing"]["number_of_guest"]
  	price = params["listing"]["price"]
  	category = params["category"]
  	type = params["room"]
  	@listing = Listing.new(location: location, user_id: current_user.id, number_of_guest: guest , price:
  		price , category: category, title: title, type_of_room: type)

  	if @listing.save 
  		redirect_to @listing 
  	else 
  		redirect_to new_listing_path 
  	end 
  end 

  def search 
  	# byebug 
  	@listing = [] 
  	@host = []
  	key = params[:finding].downcase 
  	@find = Listing.where('title LIKE ?', "%#{key}%").or(Listing.where(location: params[:finding]))
  	# byebug 
  	# @find = Listing.where(location=params[:finding])
  	@find.each do |i|
  		@listing << i 
  		@host << User.find(i.user_id).name
  	end 
  	# byebug 
  	@merge = @host.zip(@listing)
  	# byebug 
  end 

  def destroy 
  	# byebug 
  	destroy = Listing.delete(params[:id])
  	redirect_to listings_path
  end 
end
