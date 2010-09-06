class Admin::UserProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  
  def create
    @up = UserProject.new(params[:user_project])
    @up.project.assign_user(@up.user) unless @up.user.nil?
    redirect_to edit_admin_project_path(@up.project)
  end
  
  def destroy
    @up = UserProject.find(params[:id])
    @up.destroy
    redirect_to edit_admin_project_path(@up.project)
  end
  
end
