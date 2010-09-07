require 'spec_helper'

describe "Users" do
  
  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :session_email,    :with => ""
        fill_in :session_password, :with => ""
        click_button
        response.should render_template('sessions/new')
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
  
  describe "admin management" do
    before(:each) do
      admin = Factory(:user, :admin => true)
      integration_sign_in(admin)
    end
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit new_admin_user_path
          click_button
          response.should render_template('new')
          response.should have_tag("div.fieldWithErrors")
        end.should_not change(User, :count)
      end
      it "should make a new user" do
        lambda do
          visit new_admin_user_path
          fill_in :user_name, :with => "New User"
          fill_in :user_email, :with => "valid@email.com"
          click_button
          response.should render_template('admin/users/index')
        end.should change(User, :count).by(1)
      end
    end
  end
  
end
