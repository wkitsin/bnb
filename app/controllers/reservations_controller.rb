class ReservationsController < ApplicationController

	def new 
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new
		# byebug 
	end

	def create 
		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]

		if @reservation.save 
			flash[:notice] = "Your reservation has been booked"
		else 
			# byebug 
			flash[:error] = @reservation.errors.full_messages
		end 
		redirect_to listing_reservation_path(params[:listing_id], @reservation.id)
	end  

	def show 
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.find(params[:id])
		@total_price = (DateTime.parse(@reservation.check_out) - DateTime.parse(
			@reservation.check_in)).to_i * @listing.price 
		# byebug 
	end 

	private 
	def reservation_params 
		params.require(:reservation).permit(:check_in, :check_out, :listing_id)
	end 
end
