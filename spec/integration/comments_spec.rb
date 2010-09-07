require 'spec_helper'

describe "Comments" do

  describe "with no tasks on the day" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end
    it "should not show any comment fields" do
      visit root_path
      response.should_not have_tag("form#new_comment")
    end
  end
  
  describe "with a general task" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
      submit_task
    end
    it "should not send an empty comment" do
      lambda do
        visit root_path
        click_button
      end.should_not change(Comment, :count)
    end
    it "should send a comment" do
      lambda do
        visit root_path
        fill_in :comment_content, :with => "My personal opinion"
        click_button
      end.should change(Comment, :count).by(1)
    end
  end
  
  describe "with a project task" do
    before(:each) do
      @user = Factory(:user)
      @project = Factory(:project)
      @project.users << @user
      integration_sign_in(@user)
      submit_task
      @task = @project.tasks.first
    end
    it "should not send an empty comment" do
      lambda do
        visit root_path
        click_button
      end.should_not change(@task.comments, :count)
    end
    it "should send a comment" do
      lambda do
        visit root_path
        fill_in :comment_content, :with => "My personal opinion"
        click_button
      end.should change(@task.comments, :count).by(1)
    end
  end
  
end
