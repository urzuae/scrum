class WipController < ApplicationController
  before_filter :authenticate
  
  def wip
    @user = current_user
    @task = Task.new
    @comment = Comment.new
    @today = Date.today
  end
end
