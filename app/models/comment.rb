class Comment < ActiveRecord::Base
  attr_accessible :content, :task_id, :user_id
  after_create :notify_users
  
  validates_presence_of :content, :task_id, :user_id
  
  belongs_to :task
  belongs_to :user
  
  def notify_users
    user = self.task.user
    commenters = self.get_commenters
    UserMailer.deliver_comment_notification(self, user, commenters)
  end
  
  def get_commenters
    @commenters = []
    self.task.comments.each do |cmt|
      if !@commenters.include?(cmt.user.email) && cmt.user.email != self.user.email
        @commenters << cmt.user.email
      end
    end
    return @commenters = @commenters.join(", ")
  end
  
end
