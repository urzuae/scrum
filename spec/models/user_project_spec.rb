require 'spec_helper'

describe UserProject do
  
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:project_id) }
  end
  
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end
  
end
