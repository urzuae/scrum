require 'spec_helper'

describe "Tasks" do
  
  describe "during WIP in for general task" do
    before(:each) do
      @user = Factory(:user)
      @project = Factory(:project)
      integration_sign_in(@user)
    end
    describe "failure" do
      it "should not make a new general task" do
        lambda do
          visit wip_path
          click_button
          response.should render_template('wip')
        end.should_not change(Task, :count)
      end
      it "should make a new general task" do
        lambda do
          visit wip_path
          fill_in :task_content, :with => "This is mu trask for today"
          click_button
          response.should render_template('wip')
        end.should change(Task, :count).by(1)
      end
    end
  end
  
  describe "during WIP in for a project task" do
    before(:each) do
      @user = Factory(:user)
      @project = Factory(:project)
      @project.users << @user
      integration_sign_in(@user)
    end
    describe "failure" do
      it "should not make a new task for the project" do
        lambda do
          visit wip_path
          click_button :task_submit
          response.should render_template('wip')
        end.should_not change(@project.tasks, :count)
      end
      it "should make a new task for the project" do
        lambda do
          visit wip_path
          fill_in :task_content, :with => "This is mu trask for today"
          click_button :task_submit
          response.should render_template('wip')
        end.should change(@project.tasks, :count).by(1)
      end
    end
  end
  
  
end
