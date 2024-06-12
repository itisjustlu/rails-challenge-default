require 'rails_helper'

RSpec.describe Users::Finders::ByMetadata do
  subject { described_class.call(users: users, params: params) }

  let(:users) { User.all }
  let!(:user_1) { create(:user, metadata: 'adjusting metadata') }
  let!(:user_2) { create(:user, metadata: 'another metadata') }

  describe '.call' do
    context 'when metadata exists' do
      let(:params) { { metadata: 'adjusting' } }

      it 'returns the user' do
        expect(subject.users).to eq([user_1])
      end
    end

    context 'when metadata is nil' do
      let(:params) { { metadata: nil } }

      it 'returns all users' do
        expect(subject.users).to eq([user_1, user_2])
      end
    end
  end
end