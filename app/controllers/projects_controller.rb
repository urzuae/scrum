class ProjectsController < ApplicationController
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
  end
  
  def index
    @projects = Project.all
  end
  
  def edit
    @project = Project.find(params[:id])
    @users = User.all
  end
end
