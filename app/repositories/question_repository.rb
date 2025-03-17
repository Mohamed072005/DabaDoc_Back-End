  class QuestionRepository
    def self.create(question_params, user)
      permitted_params = if question_params.respond_to?(:permit)
                           question_params.permit(:title, :content, location: [:latitude, :longitude])
                         else
                           question_params
                         end
      location_hash = permitted_params[:location].to_h if permitted_params[:location].present?

      Question.create(
        {
          title: permitted_params[:title],
          content: permitted_params[:content],
          location: location_hash,
          user_id: user
        }
      )
    end

    def self.get_all_questions
      format_questions(Question.all.includes(:user, :answers, :likes).order(created_at: :desc))
    end

    def self.get_paginated_questions(page = 1, per_page = 5)
      page = [page.to_i, 1].max
      per_page = [[per_page.to_i, 10].min, 1].max

      total_count = Question.count
      total_pages = (total_count.to_f / per_page).ceil

      questions = Question.includes(:user, :answers, :likes)
                          .order(created_at: :desc)
                          .limit(per_page)
                          .offset((page - 1) * per_page)

      # Format questions for response
      formatted_questions = format_questions(questions)

      # Return hash with questions and pagination info
      {
        questions: formatted_questions,
        total_pages: total_pages,
        total_count: total_count
      }
    end

    private
    def self.format_questions(questions)
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