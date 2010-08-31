class DashboardController < ApplicationController
  before_filter :authenticate
  
  def index
    @user = current_user
    @projects = @user.projects
    @comment = Comment.new
    @day = (params[:day] || Date.today).to_date
  end
  
end
