class GeocoderRoutes < Application
  namespace '/v1' do
    get do
      geocoder_params = validate_with!(GeocoderParamsContract)

      result = Geocoder::FindCodeService.call(geocoder_params[:geocoder][:city])

      if result.success?
        status 201
        json data: result.code
      else
        status 422
        error_response result.errors
      end
    end
  end
end
