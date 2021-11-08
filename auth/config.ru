require_relative 'config/environment'

map '/auth' do
  run AuthRoutes
end
