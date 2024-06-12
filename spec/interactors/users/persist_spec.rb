require 'rails_helper'

RSpec.describe Users::Persist do
  subject { described_class.call(attributes: attributes) }

  let(:attributes) do
    {
      email: email,
      phone_number: '+12312312',
      full_name: SecureRandom.hex,
      password: 'password',
      password_confirmation: 'password',
      key: SecureRandom.hex
    }
  end

  let(:email) { "#{SecureRandom.hex}@firstleaft.com" }

  describe '.call' do
    it 'succeed' do
      expect(subject).to be_a_success
    end

    it 'creates an user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'assigns user' do
      expect(subject.user).to be_a(User)
    end

    context 'when attributes are not valid' do
      let(:email) { nil }

      it 'does not create an user' do
        expect { subject }.not_to change(User, :count)
      end

      it 'does not assign user' do
        expect(subject.user).to be_nil
      end

      it 'fails' do
        expect(subject).to be_a_failure
      end
    end
  end
end