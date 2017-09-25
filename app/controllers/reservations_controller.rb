class ReservationsController < ApplicationController
	before_action  :reservation_allowed?, only: [ :destroy]
	def new 
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new
		# byebug 
	end

	def create 
		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]
		@reservation.price = (DateTime.parse(@reservation.check_out) - DateTime.parse(
			@reservation.check_in)).to_i * @reservation.listing.price 

		if @reservation.save 
			flash[:notice] = "Your reservation has been booked"
			redirect_to listing_reservation_path(@reservation.listing, @reservation)
		else 
			# byebug 
			flash[:error] = @reservation.errors.full_messages
			redirect_to root_path 
		end 

	end  

	def show 
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.find(params[:id])
		@total_price = (DateTime.parse(@reservation.check_out) - DateTime.parse(
			@reservation.check_in)).to_i * @listing.price 
		# byebug 
	end 

	def all
		@reservations = current_user.reservations 
		@total_price = []
		@listing = [] 
		@reservations.each do |i|
			@listing << i.listing 
		end 
		@merge = @reservations.zip(@listing, @total_price)
	end 

	def destroy 
		reservation = Reservation.delete(params[:id])
		flash[:notice] = "Your reservation has been canceled"
		redirect_to reservations_path 
	end 

	private 
	def reservation_params 
		params.require(:reservation).permit(:check_in, :check_out, :listing_id)
	end 
end
