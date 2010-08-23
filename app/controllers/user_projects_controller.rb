class UserProjectsController < ApplicationController
  
  def create
  end
  
  def destroy
    @up = UserProject.find(params[:id])
    @up.destroy
    respond_to do |format|
      format.js
    end
  end
end
