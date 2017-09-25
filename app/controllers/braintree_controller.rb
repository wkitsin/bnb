class BraintreeController < ApplicationController

	def new
	  @client_token = Braintree::ClientToken.generate
	  # byebug 
	end

	def checkout
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
	  re = Reservation.find(params[:reservation_id])
	  result = Braintree::Transaction.sale(
	   :amount => re.price, 
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	  	flash[:notice] = "Transaction at #{re.listing.location} from #{re.check_in}
	  	to #{re.check_out} has been successful!"
	  	paid = re.update(paid_statusm: true)
	  	customer = re.user
	  	host = re.listing.user
	  	reservation = re.listing.title 
	  	ReservationJob.perform_later(customer, host, reservation)
	    redirect_to reservations_path 
	  else
	  	flash[:notice] =  "Transaction failed. Please try again." 
	    redirect_to reservations_path 
	  end 
	end
end
