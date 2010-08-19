require 'spec_helper'

describe UserProyects do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :proyect_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    UserProyects.create!(@valid_attributes)
  end
end
