class UsersController < ApplicationController
  def new
    if current_user
      redirect_to sites_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if User.find_by(email: @user.email)
      redirect_to new_user_path
      flash[:error] = "sorry that email already is associated with an account"
    else  
      if @user.save
        session[:user_id] = @user.id
        redirect_to scripts_path(current_user.id)
      else
        redirect_to new_user_path
        flash[:error] = "aww shucks, user was not created!"
      end
    end  
  end

  def index
    @users = User.all
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

end
