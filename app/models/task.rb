class Task < ActiveRecord::Base
  validates_presence_of :content
  
  belongs_to :user
  has_many :comments
end
