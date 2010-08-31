require 'spec_helper'

describe Admin::UsersController do

  #Delete this example and add some real ones
  it "should use Admin::UsersController" do
    controller.should be_an_instance_of(Admin::UsersController)
  end
  
  describe "GET 'index'" do
    describe "for non-sign-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      
      describe "for non-admin users" do
        before(:each) do
          @user = test_sign_in(Factory(:user))
        end
        it "should deny access" do
          get :index
          response.should redirect_to(root_path)
        end
      end
      
      describe "for admin uses" do
        before(:each) do
          @attributes = {
            :name => "admin", :email => "admin@localhost.com", :password => "123456", :password_confirmation => "123456", :admin => true
          }
          @user = test_sign_in(Factory(:user, @attributes))
        end
        it "should grant access" do
          get :index
          response.should be_success
        end
      end
      
    end
    
  end
  
  describe "GET 'new'" do
    describe "for non-sign-in users" do
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
      end
    end
    describe "for signed-in users" do
      
      describe "for non-admin users" do
        before(:each) do
          @user = test_sign_in(Factory(:user))
        end
        it "should deny access" do
          get :new
          response.should redirect_to(root_path)
        end
      end
      
      describe "for admin uses" do
        before(:each) do
          @attributes = {
            :name => "admin", :email => "admin@localhost.com", :password => "123456", :password_confirmation => "123456", :admin => true
          }
          @user = test_sign_in(Factory(:user, @attributes))
        end
        it "should grant access" do
          get :new
          response.should be_success
        end
      end
      
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @admin_attr = {
        :name => "admin",
        :email => "admin@localhost.com",
        :password => "123456",
        :password_confirmation => "123456",
        :admin => true
      }
      @admin = test_sign_in(Factory(:user, @admin_attr))
    end
    describe "failures" do
      before(:each) do
        @attributes = {
          :name => "",
          :email => "",
          :password => "",
          :password_confirmation => ""
        }
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
        @attributes = {
          :name => "New User",
          :email => "user@example.com",
          :password => "random_one",
          :password_confirmation => "random_one"
        }
        @user = Factory.build(:user, @attributes)
        User.stub!(:new).and_return(@user)
        @user.register
      end
      it "should create a confirmation_token" do
        post :create, :user => @attributes
        @user.confirmation_token.should_not be_nil
      end
      it "should change state of user" do
        post :create, :user => @attributes
        @user.registered?.should be_true
      end
    end
  end
  
end
