class Reservation < ApplicationRecord
	belongs_to :user 
	belongs_to :listing
	validate :overlapping_dates 

	def overlapping_dates 
		# byebug
		listing.reservations.each do |old_booking|
			if overlap?(self,old_booking)
				return errors.add(:overlapping_dates,
				 "The reservation has already been booked")
			end 
		end 
	end 

	# def date_not_available

	def overlap?(x,y)	
		# byebug
		(Time.parse(x.check_in) - Time.parse(y.check_out)) * (Time.parse(y.check_in) - Time.parse(x.check_out)) > 0 ;
	end 
end
