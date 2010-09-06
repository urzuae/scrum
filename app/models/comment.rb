class Comment < ActiveRecord::Base
  attr_accessible :content, :task_id, :user_id
  after_create :notify_users
  
  validates_presence_of :content, :task_id, :user_id
  
  belongs_to :task
  belongs_to :user
  
  def notify_users
    user = self.task.user
    UserMailer.deliver_comment_notification(self, user)
  end
  
end
