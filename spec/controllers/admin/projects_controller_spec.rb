require 'spec_helper'

describe Admin::ProjectsController do

  #Delete this example and add some real ones
  it "should use Admin::ProjectsController" do
    controller.should be_an_instance_of(Admin::ProjectsController)
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
        it "should denny access" do
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
          :description => ""
        }
        @project = Factory.build(:project, @attributes)
        Project.stub!(:new).and_return(@project)
        @project.should_receive(:save).and_return(false)
      end
      it "should render the 'new' page" do
        post :create, :project => @attributes
        response.should render_template('new')
      end
    end
    describe "success" do
      before(:each) do
        @attributes = {
          :name => "New Project",
          :description => "One of the first projects ever"
        }
        @project = Factory(:project, @attributes)
        Project.stub!(:new).and_return(@project)
      end
      it "should render to project page" do
        post :create, :project => @attributes
        response.should redirect_to(admin_project_path(@project))
      end
    end
  end

end
