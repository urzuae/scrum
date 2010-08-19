class UserProjectsController < ApplicationController
  def create
    @user_project = UserProject.new(params[:user_project])
    if @user_project.save
      redirect_to @user_project.project
    else
      redirect_to root_path
    end
  end
end
