require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "Henruz",
      :email => "henruz@freshout.us",
      :password => "123456",
      :password_confirmation => "123456"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  it "should require an email" do
    user_email = User.new(@valid_attributes.merge(:email => ""))
    user_email.should_not be_valid
  end
  
  it "should require a name" do
    user_name = User.new(@valid_attributes.merge(:name => ""))
    user_name.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    emails = %w[it@freshout.us urzuae@gmail.com enrique_urzua@yahoo.com.mx]
    emails.each do |email|
      user_email = User.new(@valid_attributes.merge(:email => email))
      user_email.should be_valid
    end
  end
  it "should reject invalid addresses" do
    emails = %w[trasvina@fresh,com urzua_at_gmail.co youyube@it.]
    emails.each do |email|
      user_email = User.new(@valid_attributes.merge(:email => email))
      user_email.should_not be_valid
    end
  end
  
end
