RSpec.describe AdRoutes, type: :routes do
  describe 'GET /v1' do
    let(:user_id) { 101 }

    before do
      create_list(:ad, 3, user_id: user_id)
    end

    it 'returns a collection of ads' do
      get '/v1'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /v1' do
    let(:user_id) { 101 }
    let(:auth_token) { 'auth.token' }
    let(:auth_service) { instance_double('Auth service') }
    let(:geocoder_service) { instance_double('Geocoder service') }
    let(:geocode) {
      {
        'lat' => 55.7540471,
        'lon' => 37.620405
      }
    }

    before do
      allow(auth_service).to receive(:auth).and_return(user_id)
      allow(AuthService::Client).to receive(:new).and_return(auth_service)

      header 'Authorization', "Bearer #{auth_token}"

      allow(geocoder_service).to receive(:geocode).and_return(geocode)
      allow(GeocoderService::Client).to receive(:new).and_return(geocoder_service)
    end

    context 'missing parameters' do
      it 'returns an error' do
        post '/v1'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        post '/v1', ad: ad_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Field must be filled',
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'missing user_id' do
      let(:user_id) { nil }

      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      it 'returns an error' do
        post '/v1', ad: ad_params

        expect(last_response.status).to eq(403)
        expect(response_body['errors']).to include('detail' => 'Access denied')
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { post '/v1', ad: ad_params }
          .to change { Ad.count }.by(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/v1', ad: ad_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end
end
