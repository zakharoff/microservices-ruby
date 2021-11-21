module Geocoder
  def latitude_longitude(city)
    geocoder_service.geocode(city)
  end

  private

  def geocoder_service
    @geocoder_service ||= GeocoderService::Client.new
  end
end
