RSpec.describe Ads::CreateService do
  subject { described_class }

  let(:user_id) { 101 }
  let(:geocode) {
      {
        'lat' => 55.7540471,
        'lon' => 37.620405
      }
    }

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { subject.call(ad: ad_params, user_id: user_id, geocode: geocode) }
        .to change { Ad.count }.by(1)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id, geocode: geocode)

      expect(result.ad).to be_kind_of(Ad)
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

    it 'does not create ad' do
      expect { subject.call(ad: ad_params, user_id: user_id, geocode: geocode) }
        .not_to change { Ad.count }
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id, geocode: geocode)

      expect(result.ad).to be_kind_of(Ad)
    end
  end
end
