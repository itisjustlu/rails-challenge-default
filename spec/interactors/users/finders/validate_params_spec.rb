require 'rails_helper'

RSpec.describe Users::Finders::ValidateParams do
  subject { described_class.call(params: params) }

  describe '.call' do
    context 'when params is empty' do
      let(:params) { {} }

      it 'succeed' do
        expect(subject).to be_success
      end
    end

    context 'when params contains one valid attribute' do
      let(:params) { { email: 'email@firstleaf.com' } }

      it 'succeed' do
        expect(subject).to be_success
      end
    end

    context 'when contains all valid attributes' do
      let(:params) { { email: 'firstleaft@firstleaf.com', full_name: 'Test', metadata: 'Metadata' } }

      it 'succeed' do
        expect(subject).to be_success
      end
    end

    context 'when params contains an invalid attribute' do
      let(:params) { { cellphone: 'invalid' } }

      it 'fails' do
        expect(subject).to be_failure
      end

      it 'returns an error message' do
        expect(subject.errors).to eq('Invalid query params')
      end

      it 'returns unprocessable entity status' do
        expect(subject.status).to eq(:unprocessable_entity)
      end
    end
  end
end