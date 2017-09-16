class UsersController < Clearance::UsersController
	before_action :require_login,  only: [:index, :edit, :update]

	def index 
		puts "+++++++++++++++++++"
		puts params 
		@email = current_user.email 
	end 

	def edit 
		# @mesage = 'hi'
		@users = User.find(params[:id])                             
	end 

	def update 
		# byebug 
		@users = User.update(name: params[:name], email: params[:email])
	end 

	def profile 
		@user = User.find(current_user.id).email 
	end 

	 def user_from_params
	    email = user_params.delete(:email)
	    password = user_params.delete(:password)
	    name = user_params.delete(:name)

	    Clearance.configuration.user_model.new(user_params).tap do |user|
	      user.email = email
	      user.password = password
	      user.name = name 
	    end
	end
end
