class Task < ActiveRecord::Base
  attr_accessible :content, :user_id, :project_id
  
  validates_presence_of :content, :user_id, :project_id
  
  after_create :task_submit
  
  belongs_to :user
  belongs_to :project
  has_many :comments
  
  named_scope :previous_five, :order => "created_at DESC", :limit => 5
  named_scope :by_day, lambda { |day|
    {:conditions => ["created_at BETWEEN ? AND ?", day.beginning_of_day.utc, day.end_of_day.utc]}
  }
  
  named_scope :previous, :conditions => ["project_id = ?", 0], :order => "created_at DESC", :limit => 5
  named_scope :find_by_day, lambda { |day|
    {:conditions => ["project_id = ? AND created_at BETWEEN ? AND ?",0, day.beginning_of_day.utc, day.end_of_day.utc]}
  }
  
  def task_submit
    self.user.submit_task
  end
  
end
