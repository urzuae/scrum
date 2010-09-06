class UserProject < ActiveRecord::Base
  attr_accessible :user_id, :project_id
  
  belongs_to :user
  belongs_to :project
  
  after_destroy :not_enroll_user
  
  validates_presence_of :user_id, :project_id
  
  def not_enroll_user
    self.user.not_enroll
  end
  
end
