class QuestionController < ApplicationController
  include AuthenticateRequest
  def create_question
    user = @current_user
    result = QuestionService.handle_create_question(params, user._id)
    if result.success?
      render json: { message: 'Question successfully created', question: result.data }
    else
      render json: { message: result.error }, status: result.status
    end
  end

  private

  def question_params
    params.permit(:title, :content, :location)
  end
end
