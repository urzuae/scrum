class Comment < ActiveRecord::Base
  validates_presence_of :content, :task_id, :user_id
  
  belongs_to :task
  belongs_to :user
  
end
