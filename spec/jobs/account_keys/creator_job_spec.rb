require 'rails_helper'

RSpec.describe AccountKeys::CreatorJob, type: :job do
  subject { described_class.new.perform(user.id) }

  let(:user) { create(:user) }

  describe '.retries' do
    it 'has a retry value of 5' do
      expect(described_class.sidekiq_options['retry']).to eq(5)
    end
  end

  describe '.perform' do
    context 'when the request is successful' do
      before do
        allow(AccountKeys::Client).to receive(:call).and_return(
          double(success?: true, body: { account_key: '123' }.to_json)
        )
      end

      it 'updates the user account key' do
        expect { subject }.to change { user.reload.account_key }.to('123')
      end
    end

    context 'when the request fails' do
      before do
        allow(AccountKeys::Client).to receive(:call).and_return(
          double(success?: false)
        )
      end

      it 'raises an error' do
        expect { subject }.to raise_error("Error creating account key for user #{user.id}")
      end
    end
  end
end