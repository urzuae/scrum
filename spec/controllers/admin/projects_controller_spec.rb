require 'spec_helper'

describe Admin::ProjectsController do
  #Delete this example and add some real ones
  it "should use Admin::ProjectsController" do
    controller.should be_an_instance_of(Admin::ProjectsController)
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
    it "should deny access to edit page" do
      get :edit
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
    it "should deny access to edit page" do
      get :edit
      response.should redirect_to(root_path)
    end
  end
  
  describe "admin user" do
    before(:each) do
      @admin = test_sign_in(Factory(:user, :admin => true))
    end
    describe "GET 'index'" do
      it "should grant access" do
        get :index
        response.should be_success
        response.should render_template('index')
      end
    end
    describe "GET 'new'" do
      it "should grant access" do
        get :new
        response.should be_success
        response.should render_template('new')
      end
    end
    describe "POST 'create'" do
      describe "failures" do
        before(:each) do
          @attributes = { :name => "", :description => "" }
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
          @project = Factory(:project)
          Project.stub!(:new).and_return(@project)
        end
        it "should render to project page" do
          post :create, :project => @attributes
          response.should redirect_to(admin_project_path(@project))
        end
      end
    end
    describe "GET 'edit'" do
      before(:each) do
        @project = Factory(:project)
      end
      it "should grant access" do
        get :edit, :id => @project
        response.should be_success
        response.should render_template('edit')
      end
    end
    describe "POST 'update'" do
      describe "failures" do
        before(:each) do
          @project = Factory(:project)
          @attributes = { :name => "", :description => ""}
        end
        it "should re-render the 'edit' page" do
          post :update, :id => @project, :project => @attributes
          response.should render_template('edit')
        end
      end
      describe "success" do
        before(:each) do
          @project = Factory(:project)
          @attributes = { :name => "Rename Project", :description => "Another Description"}
        end
        it "should redirect to project page" do
          post :update, :id => @project, :project => @attributes
          response.should redirect_to(admin_project_path(@project))
        end
      end
    end
    
  end
end
