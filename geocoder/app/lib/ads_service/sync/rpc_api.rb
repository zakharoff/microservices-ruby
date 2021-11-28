module AdsService
  module Sync
    module RpcApi
      def update_coordinates(id, coordinates)
        connection.patch do |request|
          request.params = { id: id, coordinates: coordinates }
        end
      end
    end
  end
end
