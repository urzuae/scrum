require 'spec_helper'

describe UserProject do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :project_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    UserProject.create!(@valid_attributes)
  end
  
  it "should validate presence of user_id and project_id" do
    @up = UserProject.new(:user_id => "", :project_id => "")
    @up.should_not be_valid
  end
end
