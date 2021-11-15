RSpec.describe UserSessions::CreateService do
  subject { described_class }

  context 'valid parameters' do
    let!(:user) { create(:user, email: 'bob@example.com', password: 'givemeatoken') }

    it 'creates a new session' do
      expect { subject.call('bob@example.com', 'givemeatoken') }
        .to change { user.sessions(reload: true).count }.by(1)
    end

    it 'assigns session' do
      result = subject.call('bob@example.com', 'givemeatoken')

      expect(result.session).to be_kind_of(UserSession)
    end
  end

  context 'missing user' do
    it 'does not create session' do
      expect { subject.call('bob@example.com', 'givemeatoken') }
        .not_to change { UserSession.count }
    end

    it 'adds an error' do
      result = subject.call('bob@example.com', 'givemeatoken')

      expect(result).to be_failure
      expect(result.errors).to include('Session does not create')
    end
  end

  context 'invalid password' do
    let!(:user) { create(:user, email: 'bob@example.com', password: 'givemeatoken') }

    it 'does not create session' do
      expect { subject.call('bob@example.com', 'invalid') }
        .not_to change { UserSession.count }
    end

    it 'adds an error' do
      result = subject.call('bob@example.com', 'invalid')

      expect(result).to be_failure
      expect(result.errors).to include('Session does not create')
    end
  end
end
