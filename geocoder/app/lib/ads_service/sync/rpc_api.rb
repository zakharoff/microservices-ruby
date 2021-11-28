module AdsService
  module Sync
    module RpcApi
      def update_coordinates(id, coordinates)
        response = connection.patch do |request|
          request.params = { id: id, coordinates: coordinates }
          request.headers['X-Request-Id'] = Thread.current[:request_id]
        end

        Application.logger.info(
          'requested coordinates updating', id: id, coordinates: coordinates, status: response.status
        )
      end
    end
  end
end
