class Project < ActiveRecord::Base
  attr_accessible :name, :description
  
  validates_presence_of :name
  validates_presence_of :description
  
  has_many :users, :through => :user_projects
  has_many :user_projects
  
end
