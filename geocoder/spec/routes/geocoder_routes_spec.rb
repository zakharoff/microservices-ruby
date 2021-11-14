RSpec.describe GeocoderRoutes, type: :routes do
  describe 'GET /v1' do
    context 'with valid params' do
      let(:geocoder_params) { {city: 'Москва'} }

      it 'returns a geocode' do
        get '/v1', geocoder: geocoder_params

        expect(last_response.status).to eq(200)
        expect(response_body['data']).to include(
          {
            'lat' => 55.7540471,
            'lon' => 37.620405
          }
        )
      end
    end

    context 'with invalid params' do
      context 'with empty city' do
        let(:geocoder_params) { {city: ''} }

        it 'returns 422 with error' do
          get '/v1', geocoder: geocoder_params

          expect(last_response.status).to eq(422)
          expect(response_body['errors']).to include(
          {
            'detail' => 'Resource not found'
          }
        )
        end
      end
    end


    context 'without params' do
      it 'returns 422 with error' do
        get '/v1'

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
        {
          'detail' => 'Request does not contain the necessary parameters'
        }
      )
      end
    end
  end
end
