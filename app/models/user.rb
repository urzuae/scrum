class User < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :name
  
  #before_save :encrypt_password
  
  has_many :projects, :through => :user_projects
  has_many :user_projects
  has_many :tasks
  
  
  
end
