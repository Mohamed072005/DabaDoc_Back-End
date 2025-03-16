  class AuthService
    def self.register(params)
      # Validate required parameters
      if params[:email].blank? || params[:password].blank? || params[:password_confirmation].blank?
        return ServiceResult.error('Email, password, and password confirmation are required', :bad_request)
      end

      # Validate password confirmation
      if params[:password] != params[:password_confirmation]
        return ServiceResult.error('Passwords do not match', :bad_request)
      end

      # Check for existing user
      begin
        if UserRepository.find_by_email(params[:email])
          return ServiceResult.error('Email already registered', :conflict)
        end
      rescue Mongoid::Errors::DocumentNotFound
        # This is expected - user doesn't exist yet
      end

      # Create new user
      begin
        user = UserRepository.create(params)

        if user.persisted? && user.errors.empty?
          return ServiceResult.success(nil, :created)
        else
          return ServiceResult.error(user.errors.full_messages.join(', '), :unprocessable_entity)
        end
      rescue => e
        # Log error
        # Rails.logger.error("Registration error: #{e.message}")
        return ServiceResult.error("Registration failed: #{e.message}", :internal_server_error)
      end
    end

    def self.authenticate(params)
      # Validate required parameters
      if params[:email].blank? || params[:password].blank?
        return ServiceResult.error('Email and password are required', :bad_request)
      end

      begin
        # Find user by email
        user = UserRepository.find_by_email(params[:email])

        # Authenticate user
        if user&.authenticate(params[:password])
          token = JwtService.encode(user_id: user.id)
          return ServiceResult.success({ token: token, user: { email: user.email, user_id: user.id } })
        else
          return ServiceResult.error('Invalid email or password', :unauthorized)
        end
      rescue Mongoid::Errors::DocumentNotFound
        return ServiceResult.error('User not found', :not_found)
      rescue => e
        Rails.logger.error("Authentication error: #{e.message}")
        Rails.logger.error(e.backtrace.join("\n"))
        # Log error
        # Rails.logger.error("Authentication error: #{e.message}")
        return ServiceResult.error('Authentication failed', :internal_server_error)
      end
    end
  end
