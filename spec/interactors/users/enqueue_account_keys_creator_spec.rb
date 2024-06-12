require 'rails_helper'

RSpec.describe ::Users::EnqueueAccountKeysCreator do
  subject(:context) { described_class.call(user: user) }

  let(:user) { build_stubbed(:user) }

  it 'enqueues AccountKeys::CreatorJob' do
    expect(::AccountKeys::CreatorJob).to receive(:perform_later).with(user.id)
    context
  end
end