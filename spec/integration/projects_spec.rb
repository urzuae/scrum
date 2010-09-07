require 'spec_helper'

describe "Projects" do
  describe "admin management" do
    before(:each) do
      admin = Factory(:user, :admin => true)
      integration_sign_in(admin)
    end
    describe "failure" do
      it "should not make a new project" do
        lambda do
          visit new_admin_project_path
          click_button
          response.should render_template('new')
          response.should have_tag("div.fieldWithErrors")
        end.should_not change(Project, :count)
      end
      it "should make a new project" do
        lambda do
          visit new_admin_project_path
          fill_in :project_name, :with => "New Project"
          fill_in :project_description, :with => "This is a brand new project"
          click_button
          response.should render_template('show')
        end.should change(Project, :count).by(1)
      end
    end
  end
end
