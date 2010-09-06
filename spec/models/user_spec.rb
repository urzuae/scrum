require 'spec_helper'

describe User do
  
  describe "relationships" do
    it { should have_many(:tasks) }
    it { should have_many(:comments) }
    it { should have_many(:user_projects) }
    it { should have_many(:projects).through(:user_projects) }
  end
  
  describe "attr_accesible attributes" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
  end
  
  describe "protected attributes from mass_assignment" do
    it { should_not allow_mass_assignment_of(:admin) }
    it { should_not allow_mass_assignment_of(:confirmation_token) }
    it { should_not allow_mass_assignment_of(:remember_token) }
    it { should_not allow_mass_assignment_of(:state) }
    it { should_not allow_mass_assignment_of(:salt) }
    it { should_not allow_mass_assignment_of(:encrypted_password) }
    it { should_not allow_mass_assignment_of(:task_submitted) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    
    describe "password encryption" do
      before(:each) do
        @attributes = {:name => "test user", :email => "user@test.info"}
      end
      it "should not encrypt blank password" do
        @user = User.create(@attributes)
        @user.update_attributes(:password => " ", :password_confirmation => " ")
        @user.should_not be_valid
      end
      it "should encrypt password" do
        @user = Factory(:user)
        @user.password.should_not == @user.encrypted_password
      end
    end
    
    describe "generation of password" do
      it "should have a password and password confirmation" do
        user = Factory(:user)
        user.password.should_not be_nil
        user.password_confirmation.should_not be_nil
      end
      it "should have an encrypted password" do
        user = Factory(:user)
        user.encrypted_password.should_not be_nil
      end
    end
    
    describe "email validations" do
      it { should validate_presence_of(:email) }
      it { user = Factory(:user)
           should validate_uniqueness_of(:email) }
      
      describe "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          it { should allow_value(address).for(:email) }
        end
      end
      describe "should reject invalid addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          it { should_not allow_value(address).for(:email) }
        end
      end
    end
  end
  
  describe "act as state machine" do
    before(:each) do
      @attributes = {:name => "test user", :email => "user@test.info"}
      @user = User.create!(@attributes)
    end
    it "should have a 'registered' status after creation" do
      @user.state.should == "registered"
    end
    it "should have a 'activated' status after confirmation of account" do
      @user.confirm
      @user.state.should == "activated"
    end
  end
  
  describe "authentication" do
    it "should respond to an authenticate method" do
      User.should respond_to(:authenticate)
    end
    it "should not authenticate user if is not activate" do
      @user = Factory(:user)
      User.authenticate(@user.email, @user.password).should be_nil
    end
    describe "user after confirmation" do
      before(:each) do
        @user = Factory(:user)
        @user.confirmation
      end
      it "should return nil with an invalid password" do
        User.authenticate(@user.email, "invalid_password").should be_nil
      end
      it "should return user with a invalid email" do
        User.authenticate("invalid@email.com", @user.password).should be_nil
      end
      it "should success with a valid email/password combination" do
        User.authenticate(@user.email, @user.password).should_not be_nil
      end
    end
  end
  
  # TODO: a qui te faltan chingos de pruebas para toooooodos los metodos de tu clase tambien prueba los casos limite!!!
  # prueba los estads tabmien! estas pruebas de nuevo son demasiado triviales y aun todos los casos triviales no los estas porbando acuerdate de shoulda
end
