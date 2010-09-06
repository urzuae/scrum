class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :find_user
  
  def show
    @projects = @user.projects
    @comment = Comment.new
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    else
      @user.password = @user.password_confirmation = ""
      render 'edit'
    end
  end
  
  private
  
  def find_user
    redirect_to root_path unless current_user == User.find(params[:id])
    @user = current_user
  end
  
end
