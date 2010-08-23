class TasksController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(params[:task])
    if @task.save
      @user.scrum_made
      respond_to do |format|
        format.js
      end
    end
  end
  
end
