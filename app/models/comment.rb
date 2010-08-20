class Comment < ActiveRecord::Base
  validates_presence_of :content
  validates_presence_of :content
  belongs_to :task
end
