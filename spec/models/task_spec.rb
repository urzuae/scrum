require 'spec_helper'

describe Task do
  
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:project_id) }
  end
  
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
    it { should have_many(:comments) }
  end
  
  describe "named scopes" do
    it { Task.should respond_to(:previous_five) }
    it { Task.should respond_to(:by_day) }
    it { Task.should respond_to(:previous) }
    it { Task.should respond_to(:find_by_day) }
  end
  
end
