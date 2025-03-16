  class QuestionRepository
    def self.create(question_params, user)
      Question.create({ title: question_params[:title], content: question_params[:content], location: question_params[:location], user_id: user })
    end

    def self.get_all_questions()
      questions = Question.all.includes(:user, :answers, :likes).to_a

      questions.map do |question|
        {
          id: question.id.to_s,
          title: question.title,
          content: question.content,
          location: question.location,
          created_at: question.created_at,
          updated_at: question.updated_at,
          user: {
            id: question.user.id.to_s,
            email: question.user.email
          },
          answers: question.answers.map { |answer|
            {
              id: answer.id.to_s,
              content: answer.content,
              created_at: answer.created_at,
              user_id: answer.user_id.to_s
            }
          },
          likes: question.likes.map { |like|
            {
              id: like.id.to_s,
              user_id: like.user_id.to_s,
            }
          },
        }
      end
    end
  end