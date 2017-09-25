class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def allowed?
  	if User.find(current_user.id).admin == true
  		return true 
  	else 
  		return false 
  	end 
  end 

  def user_allowed?(action, params)
  	# byebug 
  	if current_user.id == params["id"].to_i
  		return action 
  	else 
  		flash[:error] = "You have no authority to perform the action"
  		redirect_to action 
  	end 
  end 

  def listing_allowed?
  	user_find = Listing.find(params[:id]).user
  	if current_user.id != user_find.id
		flash[:error] = "You have no authority to perform the action"
  		redirect_to root_path
  	end 
  end 

    def reservation_allowed?
      user_find = Reservation.find(params[:id]).user
      if current_user.id != user_find.id
      flash[:error] = "You have no authority to perform the action"
        redirect_to root_path
      end 
    end 

end
