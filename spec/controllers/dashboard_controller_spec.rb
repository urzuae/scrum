# integra las vistas con integrate_views (investiga) asi podras hacer pruebitas de integracion y probar el output html

require 'spec_helper'

describe DashboardController do

  #Delete this example and add some real ones
  it "should use DashboardController" do
    controller.should be_an_instance_of(DashboardController)
  end

  describe "GET 'index'" do
    
    describe "for non-sign-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for sign-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      it "should be succesful" do
        get :index
        response.should be_success
      end
    end
  end

end
