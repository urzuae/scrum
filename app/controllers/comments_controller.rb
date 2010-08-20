class CommentsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(params[:comment])
    if @comment.save
      redirect_to @task.user
    else
      redirect_to root_path
    end
  end
end
