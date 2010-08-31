class CommentsController < ApplicationController
  before_filter :authenticate
  
  def create
    # TODO: check nested route "task/:id/comments"
    @comment = Comment.new(params[:comment])
    if @comment.save
      UserMailer.deliver_comment_notification(@comment) if @comment.user 
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
end
