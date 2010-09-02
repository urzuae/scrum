class Task < ActiveRecord::Base
  validates_presence_of :content, :user_id, :project_id
  
  belongs_to :user
  has_many :comments

  def self.find_previous
    Task.find(:all, :conditions => ["project_id = 0"], :order => "created_at DESC", :limit => 5)
  end
  
  def self.find_by_day(day)
    Task.find(:all, :conditions => ["project_id = 0 AND created_at BETWEEN ? AND ?", day.beginning_of_day.utc, day.end_of_day.utc])
  end
  
end
