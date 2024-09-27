class AuthenticationTokenService
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  ALGORITHM_TYPE = 'HS256'.freeze

  def self.encode(user_id)
    exp = 30.minutes.from_now.to_i
    payload = { user_id: user_id, exp: exp }
    JWT.encode(payload, HMAC_SECRET, ALGORITHM_TYPE)
  end

  def self.decode(token)
    begin
      decoded_token = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }).first
      Rails.logger.info "Decoded token: #{decoded_token.inspect}"
      decoded_token
    rescue JWT::ExpiredSignature
      Rails.logger.info "Token has expired"
      nil
    rescue JWT::DecodeError => e
      Rails.logger.error "JWT Decode Error: #{e.message}"
      nil
    end
  end

  def self.valid_payload(payload)
    !expired(payload)
  end

  def self.expired(payload)
    exp = payload['exp'] || payload[:exp]
    return true unless exp

    Time.at(exp) < Time.now
  end
end
