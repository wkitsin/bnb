class ReservationMailer < ApplicationMailer

	def booking_email(customer, host, reservation)
	   @customer = customer 
	   @host = host 
	   @reservation = reservation 
	   mail(to: @host.email, subject: 'Congratulations on your new reservation')
	end

end
