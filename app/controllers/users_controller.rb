class UsersController < Clearance::UsersController
	before_action :require_login,  only: [:index, :edit, :update]
	def create 
		@user = user_from_params
		# byebug 
	    if @user.save
	      sign_in @user
	      redirect_back_or url_after_create
	    else
	      render template: "users/new"
		end
	end 
	def index 

		@email = current_user.email 
		@listings = Listing.where.not(user_id: current_user.id)

		# @merge = @not_my_listing.zip(@user)
		@merge = @listings.paginate(:page => params[:page], :per_page => 10)
		@verified = "Verify by admin"
		# byebug 
	end 

	def edit 
		user_allowed?(@users = User.find(params[:id]) , params)
        # byebug      
	end 

	def update 
		@users = User.update(user_params)
		flash[:update] = "User #{params[:name]} has been updated"
		redirect_to root_path 
	end 

	def profile 
		@user = User.find(current_user.id).email 
	end 

	private 
	 def user_from_params
	    email = user_params.delete(:email)
	    password = user_params.delete(:password)
	    name = user_params.delete(:name)
	    avatar = user_params.delete(:avatar)
	    # byebug 
	    Clearance.configuration.user_model.new(user_params).tap do |user|
	      user.email = email
	      user.password = password
	      user.name = name 
	      user.avatar = avatar 
	    end

	end

	def user_params 
		params.require(:user).permit(:name, :email, :password, :avatar)
	end 
end
