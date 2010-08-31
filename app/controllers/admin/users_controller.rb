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
    @user.password = User.generate_password
    if @user.save
      @user.register
      UserMailer.deliver_enrollment_notification(@user)
      redirect_to admin_users_path
    else
      render 'new'
    end
  end
  
  def destroy
  end
  
end
