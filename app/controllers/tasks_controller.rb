class TasksController < ApplicationController
  before_filter :authenticate
  
  # TODO: Move scrum from users to new_task, rename it to scrum on routes
  
  def create
    @task = Task.new(params[:task])
    if @task.save
      current_user.made_scrum
      redirect_to scrum_user_path(current_user)
    else
      redirect_to scrum_user_path(current_user)
    end
  end
  
end
