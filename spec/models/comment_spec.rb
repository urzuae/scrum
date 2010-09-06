require 'spec_helper'

describe Comment do
  describe "relationships" do
    it { should belong_to(:user)}
    it { should belong_to(:task) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:content)}
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:task_id) }
  end
  
end
