class Admin::UsersController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end
  
  def destroy
  end
  
end
