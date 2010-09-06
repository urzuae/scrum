require 'spec_helper'

describe CommentsController do

  #Delete this example and add some real ones
  it "should use CommentsController" do
    controller.should be_an_instance_of(CommentsController)
  end

  describe "for non-sign-in" do
    it "should redirect to signin path" do
      post :create, :comment => {:content => "This is my opinion", :task_id => 2, :user_id => 1}
      response.should redirect_to signin_path
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @project = Factory(:project)
      @user = Factory(:user)
      @project.assign_user(@user)
      @another = test_sign_in(Factory(:user, :email => Factory.next(:email)))
      @project.assign_user(@another)
      @task = Factory(:task, :user_id => @user.id, :project_id => @project.id)
    end
    it "should redirect to root_path on either case" do
      post :create, :comment => {:content => "This is my opinion", :task_id => @task.id, :user_id => @another.id}
      response.should redirect_to root_path
    end
  end

end
