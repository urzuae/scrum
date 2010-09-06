require 'spec_helper'

describe Project do
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end
  
  describe "attr_accesible" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:description) }
  end
  
  describe "relationships" do
    it { should have_many(:tasks) }
    it { should have_many(:user_projects) }
    it { should have_many(:users).through(:user_projects) }
  end
  
  describe "methods" do
    it { should respond_to(:assign_user) }
    it { should respond_to(:user_assigned?) }
  end
  
  describe "user assignment" do
    before(:each) do
      @user = Factory(:user)
      @project = Factory(:project)
    end
    it "should assign a user" do
      @project.assign_user(@user)
      @project.user_assigned?(@user).should be_true
    end
    it "should not assign a user twice" do
      @project.assign_user(@user)
      @project.assign_user(@user).should be_nil
    end
  end
  
end
