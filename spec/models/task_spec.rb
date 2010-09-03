require 'spec_helper'

describe Task do
  before(:each) do
    @valid_attributes = {
      :content => "value for content",
      :user_id => 1,
      :project_id => 2
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end
  
  it "should validate presence of content" do
    task = Task.new(@valid_attributes.merge(:content => ""))
    task.should_not be_valid
  end
  it "should validate presence of user_id and project_id" do
    task = Task.new(@valid_attributes.merge(:user_id => "", :project_id => ""))
    task.should_not be_valid
  end
  
  # TODO: no estas probando nada importante! usa factories para probar los named scopes que tienes que hacer
end
