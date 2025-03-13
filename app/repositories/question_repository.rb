  class QuestionRepository
    def self.create(question_params, user)
      Question.create({ title: question_params[:title], content: question_params[:content], location: question_params[:location], user_id: user })
    end
  end