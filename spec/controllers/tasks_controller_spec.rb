require 'spec_helper'

describe TasksController do

  #Delete this example and add some real ones
  it "should use TasksController" do
    controller.should be_an_instance_of(TasksController)
  end

  describe "POST 'create'" do
    before(:each) do
      @attributes = { :content => "Fix bugs", :user_id => 2, :project_id => 2 }
    end
    describe "failure" do
      it "should denny access to non-sign-in users" do
        post :create, :task => @attributes
        response.should redirect_to signin_path
      end
    end
    describe "success" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @project = Factory(:project)
        @project.assign_user(@user)
        @attributes = { :content => "Fix bugs", :user_id => @user.id, :project_id => @project.id }
      end
      it "redirect to wip page" do
        post :create, :task => @attributes
        response.should redirect_to(wip_path)
      end
    end
  end

end
