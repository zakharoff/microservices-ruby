RSpec.describe AuthService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { {'Content-Type' => 'application/json'} }
  let(:body) { {} }

  before do
    stubs.post('auth') { [status, headers, body.to_json] }
  end

  describe '#auth (valid token)' do
    let(:user_id) { 101 }
    let(:body) { {'meta' => {'user_id' => user_id}} }

    it { expect(subject.auth('valid.token')).to eq(user_id) }
  end

  describe '#auth (invalid token)' do
    let(:status) { 403 }

    it { expect(subject.auth('invalid.token')).to be_nil }
  end

  describe '#auth (nil token)' do
    let(:status) { 403 }

    it { expect(subject.auth(nil)).to be_nil }
  end
end
