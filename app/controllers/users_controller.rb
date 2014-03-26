class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      redirect_to new_user_path
      flash[:error] = "aww shucks, user was not created!"
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

  private 

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
