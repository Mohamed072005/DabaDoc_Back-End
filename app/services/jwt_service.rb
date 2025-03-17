class JwtService
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decode = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decode)
  rescue JWT::ExpiredSignature => e
    raise JWT::DecodeError, "Token has expired"
  rescue JWT::DecodeError => e
    raise e
  end
end