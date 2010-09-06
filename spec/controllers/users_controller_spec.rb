require 'spec_helper'

describe UsersController do

  #Delete this example and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end

  describe "GET 'show'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @another = Factory(:user, :email => Factory.next(:email))
    end
    it "should grant access to user" do
      get :show, :id => @user
      response.should be_success
      controller.current_user.should == @user
    end
    it "should not grant access to other user's info" do
      get :show, :id => @another
      response.should redirect_to root_path
    end
  end
  
  describe "edit and update" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @another = Factory(:user, :email => Factory.next(:email))
    end
    it "should grant acces to user" do
      get :edit, :id => @user
      response.should be_success
      controller.current_user.should == @user
    end
    it "should not grant access to other user' edit page" do
      get :edit, :id => @another
      response.should redirect_to root_path
    end
  end
end
