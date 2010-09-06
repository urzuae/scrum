require 'spec_helper'

describe WipController do

  #Delete this example and add some real ones
  it "should use WipController" do
    controller.should be_an_instance_of(WipController)
  end

  it "should deny access to non-sign users" do
    get :wip
    response.should redirect_to signin_path
  end
  it "should grant access to signed users" do
    @user = test_sign_in(Factory(:user))
    get :wip
    response.should be_success
  end

end
