require_relative 'rpc_api'

module AdsService
  module Sync
    class RpcClient
      extend Dry::Initializer[undefined: false]
      include RpcApi

      option :url, default: proc { Settings.microservices.ads_url }
      option :connection, default: proc { build_connection }

      private

      def build_connection
        Faraday.new(@url) do |conn|
          conn.request :json
          conn.response :json, content_type: /\bjson$/
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
