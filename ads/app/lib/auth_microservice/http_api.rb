module AuthService
  module HttpApi
    def auth(token)
      response = connection.post('auth') do |request|
        request.headers['Authorization'] = "Bearer #{token}"
      end

      response.body.dig('meta', 'user_id') if response.success?
    end
  end
end
