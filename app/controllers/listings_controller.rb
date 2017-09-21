class ListingsController < ApplicationController

	def index 
		@listing = [] 
		@host = [] 
		@listings = Listing.where(user_id: current_user.id)
		@merge = @listings.order("id ASC").paginate(:page => params[:page], :per_page => 10)
	end 

  def new
  	@listing = Listing.new 
  end
  
  def show
  	# byebug 
  	@listing = Listing.find(params[:id])
    # byebug 
  end 

  def edit 
  	# byebug 
    listing_allowed?(@listing = Listing.find(params[:id]), params)
  end 

  def update 
    @a = Listing.find(params[:id])
  	@listing = @a.update(listing_params)
  	location = @a.location
  	flash[:update] = "Your listing at #{location} has been updated"
  	redirect_to listing_path(params[:id])
  end 

  def create 
  	@listing = current_user.listings.new(listing_params)

  	if @listing.save 
  		flash[:save] = "your listing has been save"
  		redirect_to listing_path(@listing.id)
  	else 
  		flash[:save] = "your listing has not been saved"
  		redirect_to new_listings_path 
  	end 
  end 

  def search 
  	# byebug 
  	@listing = [] 
  	@host = []
  	key = params[:finding].downcase 
  	@find = Listing.where('title ILIKE ?', "%#{key}%").or(Listing.where(location: params[:finding]))
  	@merge = @find.paginate(:page => params[:page], :per_page => 10)
  	# byebug 
  end 

  def destroy 
  	# byebug 
    # listing_allowed?(Listing.delete(params[:id]), params)
    listing = Listing.find(params[:id])
    if current_user.id == listing.user.id
      listing.delete(params[:id])
      flash[:destroy] = "Your listing at #{location} has been deleted"
      redirect_to listings_path
    else 
      flash[:error] = "You have no authority to perform the action"
      redirect_to listing 
    end 
  end 

  def verify 
    @verification = Listing.find(params[:id])
    if allowed? == true 
      if @verification.verify == true
        @verify = @verification.update(verify: false)
        flash[:notice] = "The post has been unverified"
      else 
        @verify = @verification.update(verify: true)
        flash[:notice] = "The post has been verified"
      end 
    else
      flash[:notice] = "You have no authority to verify the post"
    end 
    redirect_to root_path
  end 


  private
  def listing_params
    # byebug 
  	params.require(:listing).permit(:title, :number_of_guest, :price, :category, 
      :location, :type_of_room, photos: [])
  end
end
