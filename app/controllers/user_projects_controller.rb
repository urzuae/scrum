class UserProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  
  def create
    @up = UserProject.new(params[:user_project]) # TODO: refactor up create to a project assign_user method on controller
    @up_checker = UserProject.find(:first, :conditions => ["user_id = ? AND project_id = ?", params[:user_project][:user_id] , params[:user_project][:project_id]])
    if @up_checker.nil?
      if @up.save
        @up.user.enroll
      end
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
