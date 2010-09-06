class CommentsController < ApplicationController
  before_filter :authenticate
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
end
