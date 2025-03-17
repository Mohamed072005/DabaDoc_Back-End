class QuestionController < ApplicationController
  include AuthenticateRequest
  before_action :authenticate_request, except: [:get_questions]
  def create_question
    user = @current_user
    result = QuestionService.handle_create_question(params, user._id)
    if result.success?
      render json: { message: 'Question successfully created', question: result.data }, status: :created
    else
      render json: { message: result.error }, status: result.status
    end
  end

  def get_questions
    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:perPage].present? ? params[:perPage].to_i : 5

    questions = QuestionRepository.get_paginated_questions(page, per_page)
    render json: { data: questions }, status: :ok
  rescue => e
    render json: { message: "An error occurred: #{e.message}" }, status: :internal_server_error
  end

  private

  def question_params
    params.permit(:title, :content, location: [:latitude, :longitude])
  end
end
