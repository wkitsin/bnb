class ReservationJob < ApplicationJob
  queue_as :default

  def perform(customer, host, reservation)
    ReservationMailer.booking_email(customer, host, reservation).deliver_later 
  end
end
