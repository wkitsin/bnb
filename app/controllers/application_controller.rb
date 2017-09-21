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

  def listing_allowed?(action, params)

  	user_find = Listing.find(params[:id]).user
	  	if current_user.id == user_find.id
	  		return action 
	  	else 
	  		flash[:error] = "You have no authority to perform the action"
	  		redirect_to action
	  	end 
  end 

end
