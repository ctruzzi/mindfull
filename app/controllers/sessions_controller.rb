class SessionsController < ApplicationController
  def new
	@title = "Sign in"
  	render :layout => 'signin_layout'
  end
  
  def create
    user = User.find_by_user_name(params[:session][:user_name])
    if user.nil?
      params[:session][:email] = "temp@temp.com"
      user = User.new(params[:session])
      user.save
      #add the categories for the customer
    else
      user = User.authenticate(user,"")
    end
    
    #Check if the user exists, if it doesn't then create it
  	if user.nil?
  		#User is nil menaing we didn't find that email address
  		flash.now[:error] = "Invalid email"
  		@title = "Sign in"
  		render 'new'	
  	else
  		#Sign user in and redirect to the users home page
  		sign_in user
		redirect_to user
  	end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
  
end
