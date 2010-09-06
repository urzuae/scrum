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
    before(:each) do
    end
  end
  
  # TODO: no estas probando nada importante! usa factories para probar los named scopes que tienes que hacer
end
