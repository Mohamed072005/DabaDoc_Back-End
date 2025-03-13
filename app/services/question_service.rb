  class QuestionService
    def self.handle_create_question(params, user)
      if params[:title].blank? || params[:content].blank? || params[:location].blank?
        return ServiceResult.error('Question title or content is required', :bad_request)
      end
      begin
        question = QuestionRepository.create(params, user)
        if question.persisted? && question.errors.empty?
          return ServiceResult.success(question, :created)
        else
          return ServiceResult.error(question.errors.full_messages.join(', '), :unprocessable_entity)
        end
      rescue => e
        return ServiceResult.error("Registration failed: #{e.message}", :internal_server_error)
      end
    end
  end
