class UsersController < ApplicationController
  def new
    @user = User.new
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

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @users = User.all
  end

  def scripts
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
