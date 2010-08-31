require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
      :name => "Freshout",
      :description => "Pioneering disruptive ideas on the web"
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
  it "should require a name" do
    project_name = Project.new(@valid_attributes.merge(:name => ""))
    project_name.should_not be_valid
  end
  
  it "should require a description" do
    project_desc = Project.new(@valid_attributes.merge(:description => ""))
    project_desc.should_not be_valid
  end
  
  it "should have a tasks method" do
    project = Project.create!(@valid_attributes)
    project.should respond_to(:tasks)
  end
  
  it "should have a users method" do
    project = Project.create!(@valid_attributes)
    project.should respond_to(:users)
  end
end
