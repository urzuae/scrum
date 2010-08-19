class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      #UserMailer.deliver_enrollment_notification
      redirect_to @user
    else
      render 'new'
    end
  end
  def destroy
  end
end
