require 'spec_helper'

describe Proyect do
  before(:each) do
    @valid_attributes = {
      :description => "value for description",
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Proyect.create!(@valid_attributes)
  end
end
