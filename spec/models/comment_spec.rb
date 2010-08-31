require 'spec_helper'

describe Comment do
  before(:each) do
    @valid_attributes = {
      :content => "This is my personal opinion",
      :task_id => 1,
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
  
  it "should validate presence of content" do
    comment = Comment.new(@valid_attributes.merge(:content => ""))
    comment.should_not be_valid
  end
  it "should validate presence of task_id" do
    comment = Comment.new(@valid_attributes.merge(:task_id => ""))
    comment.should_not be_valid
  end
  it "should validate presence of authos" do
    comment = Comment.new(@valid_attributes.merge(:user_id => ""))
    comment.should_not be_valid
  end
end
