require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :email => "value for email",
      :encrypted_password => "value for encrypted_password",
      :confirmation_token => "value for confirmation_token",
      :remember_token => "value for remember_token",
      :admin => false,
      :salt => "value for salt"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  describe "POST 'create'" do
    it "should require a name"
  end
end
