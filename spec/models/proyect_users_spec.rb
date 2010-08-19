require 'spec_helper'

describe ProyectUsers do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :proyect_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ProyectUsers.create!(@valid_attributes)
  end
end
