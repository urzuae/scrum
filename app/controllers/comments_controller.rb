class CommentsController < ApplicationController
  before_filter :authenticate
  
  def create
    # TODO: check nested route "task/:id/comments"
    @comment = Comment.new(params[:comment])
    if @comment.save
      # TODO: esto esta muy mal! acuerdate que los controladores deben ser delgados
      # la logica de como mandar correos debe estar en los modelos por lo general
      # muy pocos casos esta justificado algo asi en el controlador
      # tampoco pusiste bien sobre quien va a recibir los comentarios
      # acuerdate que el creador del task y todos los que han comentado en esa tarea deben recibir el correo menos el que comento!
      UserMailer.deliver_comment_notification(@comment) if @comment.user 
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
end
