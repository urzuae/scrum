class SessionsController < ApplicationController
  before_filter :check_signin, :only => [:new]
  
  def new
  end
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      render 'new'
    else
      sign_in user
      redirect_to root_path
    end
  end
  
  def destroy
    sign_out
    redirect_to signin_path
  end
  
  def register
    user = User.find_by_confirmation_token(params[:confirmation_token]) unless params[:confirmation_token].blank?
    if user && !user.active?
      user.confirmation
      @display = true
    else
      @display = false
    end
  end
  
  private
  
  def check_signin
    unless current_user.nil?
      redirect_to root_path
    end
  end
  
end
