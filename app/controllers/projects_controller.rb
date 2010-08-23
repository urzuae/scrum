class ProjectsController < ApplicationController
  before_filter :authenticate, :except => [:register]
  before_filter :admin_user, :except => [:show, :create, :index, :historical]
  
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end
  
  def show
    @project = Project.find(params[:id])
    @users = User.all
    @user_project = UserProject.new
  end
  
  def index
    @projects = Project.all
  end
  
  def historial
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end

  private
  
  def admin_user
    unless current_user.admin?
      flash[:notice] ="You do not have enough permissions"
      redirect_to(current_user)
    end
  end
  
end
