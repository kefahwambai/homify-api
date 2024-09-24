class AuthenticationTokenService
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  ALGORITHM_TYPE = 'HS256'.freeze

  def self.encode(user_id)
    exp = 30.minutes.from_now.to_i
    payload = { user_id: user_id, exp: exp }
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  # def self.decode(token)
  #   JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
  # rescue JWT::ExpiredSignature, JWT::DecodeError
  #   nil
  # end
  def self.decode(token)
    begin
      decoded_token = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }).first
      decoded_token['user_id']  # Extract the user_id from the decoded token
    rescue JWT::ExpiredSignature
      Rails.logger.info "Token has expired"
      nil
    rescue JWT::DecodeError => e
      Rails.logger.info "JWT Decode Error: #{e.message}"
      nil
    end
  end
  
  

  def self.valid_payload(payload)
    !expired(payload)
  end

  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end