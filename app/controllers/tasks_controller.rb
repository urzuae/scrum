class TasksController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(params[:task])
    if @task.save
      redirect_to @user
    else
      redirec_to root_path
    end
  end
  
end
