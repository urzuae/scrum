class UserProjectsController < ApplicationController
  def create
    @user_project = UserProject.new(params[:user_project])
    @up_checker = UserProject.find(:first, :conditions => ["user_id = ? AND project_id = ?", params[:user_project][:user_id] , params[:user_project][:project_id]])
    if !@up_checker.nil?
      redirect_to @up_checker.project
    elsif @user_project.save
      redirect_to @user_project.project
    else
      redirect_to root_path
    end
  end
end
