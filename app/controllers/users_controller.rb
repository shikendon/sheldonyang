class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    render action: 'edit' if not @user.update(user_params)
    redirect_to @user, notice: 'User was successfully updated.'
  end

  private
  def user_params
    params.require(:user).permit(:id, :email, :name, :level, :_destroy)
  end
end
