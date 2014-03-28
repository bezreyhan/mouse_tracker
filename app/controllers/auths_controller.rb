class AuthsController < ApplicationController
  def new
    if current_user
      redirect_to interactions_path
      flash[:notice] = "you are logged alreday logged in. Logout to create a new account"
    else
      @user = User.new
    end
  end

  def create
    if !(User.where(email: params[:user][:email]).empty?)
      user = User.find_by(email: params[:user][:email])
      if user.authenticated?(params[:user][:password])
        session[:user_id] = user.id
        redirect_to sites_path
        flash[:notice] = "You are logged in"
      else
        redirect_to new_auth_path
        flash[:error] = "email and password did not match"
      end
    else
      redirect_to new_auth_path
      flash[:error] = "We couldn't find that email. Try again or create an account."   
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_auth_path
  end
end
