class AuthController < ApplicationController
  skip_before_action :authenticate_request

  def login
    result = AuthService.authenticate(login_params)

    if result.success?
        render json: { data: result.data }, status: :ok
    else
      render json: { error: result.error }, status: result.status
    end
  end

  def register
    result = AuthService.register(registration_params)

    if result.success?
      render json: { message: 'Registration successful' }, status: :created
    else
      render json: { error: result.error }, status: result.status
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end
end