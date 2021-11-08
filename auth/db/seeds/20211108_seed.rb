Sequel.seed(:development, :test) do
  require_relative '../../config/environment'

  def run
    user1 = User.create(name: 'Name1', email: 'email1@example.com', password: 'password')
    user2 = User.create(name: 'Name2', email: 'email2@example.com', password: 'password')

    UserSession.create(user_id: user1.id)
    UserSession.create(user_id: user2.id)
  end
end
