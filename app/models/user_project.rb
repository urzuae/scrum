class UserProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :user_id, :project_id
  
end
