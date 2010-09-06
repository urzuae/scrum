class Project < ActiveRecord::Base
  attr_accessible :name, :description
  
  validates_presence_of :name
  validates_presence_of :description
  
  has_many :users, :through => :user_projects
  has_many :user_projects
  has_many :tasks
  
  #Assign a user to the project
  def assign_user(user)
    unless user_assigned?(user)
      self.users << user
      user.enroll
    end
  end
  
  def user_assigned?(user)
    self.users.include?(user)
  end
  
end
