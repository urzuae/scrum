require 'spec_helper'

describe Admin::UserProjectsController do
  
  describe "POST 'create'" do
    before(:each) do
      @admin = test_sign_in(Factory(:user, :admin => true))
      @user = Factory(:user, :email => Factory.next(:email))
      @project = Factory(:project)
    end
    it "should redirect to edit project page" do
      post :create, :user_project => {:user_id => @user.id, :project_id => @project.id}
      response.should redirect_to(edit_admin_project_path(@project))
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @admin = test_sign_in(Factory(:user, :admin => true))
      @user = Factory(:user, :email => Factory.next(:email))
      @project = Factory(:project)
      @up = UserProject.create(:user_id => @user.id, :project_id => @project.id )
    end
    it "should redirect to edit project page" do
      post :destroy, :id => @up
      response.should redirect_to(edit_admin_project_path(@up.project))
    end
  end
end
