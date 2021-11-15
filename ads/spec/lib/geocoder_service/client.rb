RSpec.describe GeocoderService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { {'Content-Type' => 'application/json'} }
  let(:body) { {} }

  before do
    stubs.get { [status, headers, body.to_json] }
  end

  describe '#latitude_longitude (existing city)' do
    let(:geocode) {
      {
        'lat' => 55.7540471,
        'lon' => 37.620405
      }
    }
    let(:body) { {'data' => geocode} }

    it { expect(subject.latitude_longitude('existing.city')).to eq(geocode) }
  end

  describe '#auth (unexisting city)' do
    let(:status) { 422 }

    it { expect(subject.latitude_longitude('unexisting.city')).to be_nil }
  end

  describe '#latitude_longitude (nil city)' do
    let(:status) { 422 }

    it { expect(subject.latitude_longitude(nil)).to be_nil }
  end
end
