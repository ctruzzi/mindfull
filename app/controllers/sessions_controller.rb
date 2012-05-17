class SessionsController < ApplicationController
  def new
  	@title = "Sign in"
  	render :layout => 'home_layout'
  end
  
  def create
  	user = User.authenticate(params[:session][:email],"")
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
