require 'spec_helper'

describe Admin::UsersController do

  #Delete this example and add some real ones
  it "should use Admin::UsersController" do
    controller.should be_an_instance_of(Admin::UsersController)
  end

  describe "for non-sign-in users" do
    it "should deny access to index page" do
      get :index
      response.should redirect_to(signin_path)
    end
    it "should deny access to new page" do
      get :new
      response.should redirect_to(signin_path)
    end
  end
  
  describe "for non-admin users" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    it "should deny access to index page" do
      get :index
      response.should redirect_to(root_path)
    end
    it "should deny access to new page" do
      get :new
      response.should redirect_to(root_path)
    end
  end

  describe "for admin users" do
    before(:each) do
      @admin = test_sign_in(Factory(:user, :admin => true))
    end
    describe "GET 'index'" do    
      it "should grant access" do
        get :index
        response.should be_success
      end
    end
    describe "GET 'new'" do
      it "should grant access" do
        get :new
        response.should be_success
      end
    end
    describe "POST 'create'" do
      describe "failures" do
        before(:each) do
          @attributes = { :name => "", :email => "" }
          @user = Factory.build(:user, @attributes)
          User.stub!(:new).and_return(@user)
          @user.should_receive(:save).and_return(false)
        end
        it "should render the 'new' page" do
          post :create, :user => @attributes
          response.should render_template('new')
        end
      end
      describe "success" do
        before(:each) do
          @attributes = { :name => "New User", :email => "user@example.com" }
          @user = Factory.build(:user, @attributes)
          User.stub!(:new).and_return(@user)
        end
        it "should create an encrypted_password for user" do
          post :create, :user => @attributes
          @user.encrypted_password.should_not be_nil
        end
        it "should create a confirmation_token" do
          post :create, :user => @attributes
          @user.confirmation_token.should_not be_nil
        end
        it "should should be registered" do
          post :create, :user => @attributes
          @user.registered?.should be_true
        end
        it "should send an email to user" do
          post :create, :user => @attributes
          UserMailer.deliver_enrollment_notification(@user).should_not be_nil
        end
      end
    end
  end
end
