class UserProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  
  def create
    @up = UserProject.new(params[:user_project])
    unless @up.project.user_assigned?(@up.user)
      @up.project.assign_user(@up.user)
      @up.user.enroll
    end
    redirect_to edit_admin_project_path(@up.project)
  end
  
  def destroy
    @up = UserProject.find(params[:id])
    proj = @up.project
    @up.destroy
    @up.user.not_enroll
    redirect_to edit_admin_project_path(proj)
  end
  
end
