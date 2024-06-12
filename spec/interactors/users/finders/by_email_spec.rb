require 'rails_helper'

RSpec.describe Users::Finders::ByEmail do
  subject { described_class.call(users: users, params: params) }

  let(:users) { User.all }
  let!(:user_1) { create(:user, email: 'jane@doe.com') }
  let!(:user_2) { create(:user, email: 'john@doe.com') }

  describe '.call' do
    context 'when email exists' do
      let(:params) { { email: 'jane@do' } }

      it 'returns the user' do
        expect(subject.users).to eq([user_1])
      end
    end

    context 'when email is nil' do
      let(:params) { { email: nil } }

      it 'returns all users' do
        expect(subject.users).to eq([user_1, user_2])
      end
    end
  end
end