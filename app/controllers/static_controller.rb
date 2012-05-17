class StaticController < ApplicationController
  def home
  	current_user
  	if @current_user.nil? 
  		redirect_to signin_url
  	else
  		redirect_to @current_user
  	end
  end

  def contact
  end

  def about
  end
end
