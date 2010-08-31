require 'spec_helper'

describe SessionsController do

  #Delete this example and add some real ones
  it "should use SessionsController" do
    controller.should be_an_instance_of(SessionsController)
  end

  describe "GET 'new'" do
    it "should granted access to not sign in access" do
      get :new
      response.should be_success
    end
    
    it "should redirect to root if user is already sign in" do
      user = test_sign_in(Factory(:user))
      get :new
      response.should redirect_to root_path
    end
  end
  
  describe "POST 'create'" do
    
    describe "invalid sign in" do
      before(:each) do
        @attributes = { :email => "email@example.com", :password => "password" }
        User.should_receive(:authenticate).with(@attributes[:email], @attributes[:password]).and_return(nil)
      end
      it "should render 'new' page again" do
        post :create, :session => @attributes
        response.should render_template("new")
      end
    end
    
    describe "valid sign in" do
      before(:each) do
        @user = Factory(:user)
        @attributes = { :email => @user.email, :password => @user.password }
        User.should_receive(:authenticate).with(@user.email, @user.password).and_return(@user)
      end
      it "should sign in the user" do
        post :create, :session => @attributes
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      it "should redirect to the root page" do
        post :create, :session => @attributes
        response.should redirect_to root_path
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should sign a user out and redirect to sign in page" do
      test_sign_in(Factory(:user))
      controller.should be_signed_in
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to signin_path
    end
  end
  
  describe "GET 'register'" do
    before(:each) do
      @attributes = {
        :name => "New User",
        :email => "user@local.com",
        :password => "asdfgh",
        :password_confirmation => "asdfgh"
      }
      @user = Factory(:user, @attributes)
      User.stub!(:new).and_return(@user)
      @user.register
    end
    
    describe "activation of user" do
      before(:each) do
        get :register, :confirmation_token =>  @user.confirmation_token
        @user.confirmation
      end
      it "should not redirect" do
        response.should render_template("register")
      end
      it "should change state of user" do
        @user.activated?.should be_true
      end
      
      it "should delete confirmation_token" do
        @user.confirmation_token.should be_nil
      end
    end
  end

end
