module Auth
  class Unauthorized < StandardError; end

  AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

  def user_id
    user_id = auth_service.auth(matched_token)
    raise Unauthorized unless user_id
    user_id
  end

  private

  def auth_service
    @auth_service ||= AuthService::Client.new
  end

  def matched_token
    result = auth_header&.match(AUTH_TOKEN)
    return if result.blank?

    result[:token]
  end

  def auth_header
    request.env['HTTP_AUTHORIZATION']
  end
end
