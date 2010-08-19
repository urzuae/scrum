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
end
