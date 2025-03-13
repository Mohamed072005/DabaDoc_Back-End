class LikeController < ApplicationController
  before_action :authenticate_user!
  def add_like
    @question = Question.find(params[:question_id])
    @like = current_user.likes.build(question: @question)

    if @like.save
      render json: { status: 'success', message: 'Liked successfully' }, status: :created
    else
      render json: { status: 'error', message: @like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def removeLike

  end
end
