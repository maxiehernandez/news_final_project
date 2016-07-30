class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:u_name, :email, :password, :password_confirmation, :google_auth_token)
  end
end
