RSpec.describe Geocoder::FindCodeService do
  subject { described_class }

  context 'when existing city' do
    let(:geocoder_params) { 'Москва' }
    let(:valid_code) do
      {
        "data": {
          "lat": 55.7540471,
          "lon": 37.620405
        }
      }
    end

    it 'returns a code' do
      result = subject.call(geocoder_params)

      expect(result.code).to include(
          {
            lat: 55.7540471,
            lon: 37.620405
          }
        )
    end
  end

  context 'when not existing city' do
    let(:geocoder_params) { {city: ''} }

    it 'returns error' do
      result = subject.call(geocoder_params)

      expect(result.errors).to include(
          'Resource not found'
        )
    end
  end
end
