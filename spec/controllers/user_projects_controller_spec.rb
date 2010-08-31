require 'spec_helper'

describe UserProjectsController do

  #Delete this example and add some real ones
  it "should use UserProjectsController" do
    controller.should be_an_instance_of(UserProjectsController)
  end
  describe "POST 'create'" do
    before(:each) do
      @another_user = Factory(:user, :email => Factory.next(:email))
      @project = Factory(:project)
      @attributes = {
        :user_id => @another_user.id,
        :project_id => @project.id
      }
    end
    describe "non-admin users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      it "should denny access" do
        lambda do
          post :create, :user_project => @attributes
          response.should redirect_to root_path
        end.should_not change(UserProject, :count)
      end
    end
    describe "admin user" do
      before(:each) do
        @admin = test_sign_in(Factory(:user, :admin => true))
      end
      it "should denny access" do
        lambda do
          post :create, :user_project => @attributes
          response.should redirect_to admin_project_path(@project)
        end.should change(UserProject, :count)
      end
    end
  end
end
