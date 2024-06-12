require 'rails_helper'

RSpec.describe AccountKeys::Client do
  subject { described_class.new(body).call }

  let(:user) { build_stubbed(:user) }
  let(:body) { { email: user.email, key: user.key } }

  describe '.call' do
    before do
      WebMock.stub_request(:post, 'https://w7nbdj3b3nsy3uycjqd7bmuplq0yejgw.lambda-url.us-east-2.on.aws/v1/account').
        with(body: body.to_json).
        to_return(status: 200, body: { account_key: '123' }.to_json)
    end

    it 'returns body' do
      expect(subject.body).to eq({ account_key: '123' }.to_json)
    end

    it 'returns success' do
      expect(subject).to be_success
    end
  end
end