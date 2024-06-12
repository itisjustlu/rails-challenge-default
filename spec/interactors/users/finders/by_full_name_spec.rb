require 'rails_helper'

RSpec.describe Users::Finders::ByFullName do
  subject { described_class.call(users: users, params: params) }

  let(:users) { User.all }
  let!(:user_1) { create(:user, full_name: 'John Doe') }
  let!(:user_2) { create(:user, full_name: 'Jane Doe') }

  describe '.call' do
    context 'when full_name exists' do
      let(:params) { { full_name: 'Jane D' } }

      it 'returns the user' do
        expect(subject.users).to eq([user_2])
      end
    end

    context 'when full_name is nil' do
      let(:params) { { full_name: nil } }

      it 'returns all users' do
        expect(subject.users).to eq([user_1, user_2])
      end
    end
  end
end