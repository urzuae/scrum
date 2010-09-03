# TODO: no esta comentado nada en tu clase! Documenta con Rdoc! aplica para todas las clases y metodos que hagas tu
class Project < ActiveRecord::Base
  # TODO: nice! no parece que estes setteando esto en todos los demas modelos, hazlo!
  attr_accessible :name, :description
  
  validates_presence_of :name
  validates_presence_of :description
  
  has_many :users, :through => :user_projects
  has_many :user_projects
  has_many :tasks
  
  def find_today_tasks
    # TODO: esto puede ser un named_scope de tasks
    self.find_tasks_by_day(Date.today)
  end
  
  def find_tasks_by_day(day)
    # TODO: esto puede ser un named_scope de tasks
    self.tasks.find(:all, :conditions => ["created_at BETWEEN ? AND ?", day.beginning_of_day.utc, day.end_of_day.utc])
  end
  
  def find_previous_five
    # TODO: esto puede ser un named_scope de tasks
    day = Date.today.yesterday
    self.tasks.find(:all, :order => "created_at DESC", :limit => 5)
  end
  
  def assign_user(user)
    self.users << user
  end
  
  def user_assigned?(user)
    self.users.include?(user)
  end
  
end
