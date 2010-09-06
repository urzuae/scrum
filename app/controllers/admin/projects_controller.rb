class Admin::ProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  before_filter :find_project, :only => [:show, :edit, :update]
  
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
    @tasks = @project.tasks
  end
  
  def edit
    @user_project = UserProject.new
    @users = User.all
  end
  
  def update
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
  
  private
  
  def find_project
    @project = Project.find(params[:id])
  end
  
end
