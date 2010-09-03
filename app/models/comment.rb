class Comment < ActiveRecord::Base
  validates_presence_of :content, :task_id, :user_id
  
  belongs_to :task
  belongs_to :user
  
  # TODO: la logica de mailer deberia estar un callback u observer de los comentarios on create!
end
