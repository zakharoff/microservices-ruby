module GeocoderService
  module Api
    def geocode(city)
      response = connection.get do |request|
        request.params['geocoder'] = { city: city }
      end

      response.body.dig('data') if response.success?
    end
  end
end
