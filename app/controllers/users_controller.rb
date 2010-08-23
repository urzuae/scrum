class UsersController < ApplicationController
  before_filter :authenticate, :except => [:register]
  before_filter :admin_user, :except => [:show, :create]
  
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
    @task = Task.new
    @comment = Comment.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.register
      #UserMailer.deliver_enrollment_notification(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def register
    user = User.find_by_confirmation_token(params[:confirmation_token]) unless params[:confirmation_token].blank?
    if user && !user.active?
      user.confirmation
      flash[:success] = "Welcome to SCRUM. Your account was succesfully confirmed."
    else
      flash[:error] = "Your account has not been validated, check your email."
      redirect_to root_path
    end
  end
  
  def destroy
  end
  
  private
  
  def admin_user
    redirect_to(current_user) unless current_user.admin?
  end
  
end
