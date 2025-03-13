module AuthenticateRequest
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      @decode = JwtService.decode(token)
      @current_user = User.find_by(email: @decode['email'])
    rescue JWT::DecodeError, Mongoid::Errors::DocumentNotFound
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end