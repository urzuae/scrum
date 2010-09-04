class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :find_user, :except => [:update]
  
  def show
    @projects = @user.projects
    @comment = Comment.new
  end
  
  def scrum_in
    @task = Task.new
    @comment = Comment.new
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    else
      @user.password = @user.password_confirmation = ""
      render 'edit'
    end
  end
  
  private 
  
  def find_user
    @user = current_user
  end
  
end
