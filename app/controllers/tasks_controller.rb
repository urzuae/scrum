class TasksController < ApplicationController
  before_filter :authenticate
  
  # TODO: Move scrum from users to new_task, rename it to scrum on routes
  
  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to wip_path
    else
      redirect_to wip_path
    end
  end
  
end
