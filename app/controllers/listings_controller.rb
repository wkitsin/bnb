class ListingsController < ApplicationController
  before_action :listing_allowed?, only: [:edit, :update, :destroy]

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
    hash = Hash[search_params.keys.zip(search_params.values)]
    @listing = Listing
    # params[:listing] = {category: 'aaa', guest: 'bbb', general: 'ccc'}
    hash.each do |key, value|
      @listing = @listing.send(key, value)
      # Listing.send(:category, 'aaa')
      # Lising.category('aaa')

      # Listing.category('aaa').send(:guest, 'bbb')
      # Listing.category('aaa').guest('bbb')
      # byebug 
    end

  	  @search_result = [search_params]
      @search_result = @search_result.reject { |i| i.empty? }
  	@merge = @listing.paginate(:page => params[:page], :per_page => 10)

  end 

  def destroy 
    Listing.delete(params[:id])
    flash[:destroy] = "Your listing has been deleted"
    redirect_to listings_path
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
  	params.require(:listing).permit(:title, :number_of_guest, :price, :category, 
      :location, :type_of_room, photos: [])
  end

  def search_params 
      params.require(:search).permit(:general, :category, :guest, :type)
  end 
end
