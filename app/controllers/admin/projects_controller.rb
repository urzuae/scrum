class Admin::ProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to admin_project_path(@project)
    else
      render 'new'
    end
  end
  
  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks.all(:order => "created_at DESC")
  end
  
  def edit
    @project = Project.find(params[:id])
    @user_project = UserProject.new
    @users = User.all
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to admin_project_path(@project)
    else
      @user_project = UserProject.new
      @users = User.all
      render 'edit'
    end
  end
  
  def index
    @projects = Project.all
  end
  
  def history
    @project = Project.find(params[:id])
    @day = params[:day].to_date
  end
  
end
