# app/controllers/concerns/authenticate_request.rb
module AuthenticateRequest
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    unless token
      render json: { error: 'Authorization token missing' }, status: :unauthorized
      return
    end

    begin
      decoded = JwtService.decode(token)
      Rails.logger.debug "Decoded token: #{decoded.inspect}"
      user_id = decoded[:user_id] || decoded['user_id']
      @current_user = UserRepository.find_by_id(user_id)

      unless @current_user
        render json: { error: 'User not found' }, status: :unauthorized
        return
      end
    rescue JWT::DecodeError => e
      render json: { error: 'Invalid token', details: e.message }, status: :unauthorized
    rescue Mongoid::Errors::DocumentNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end
end