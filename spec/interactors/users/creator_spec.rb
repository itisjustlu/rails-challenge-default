require 'rails_helper'

RSpec.describe ::Users::Creator do
  it 'organizes' do
    expect(described_class.organized).to eq([
      ::Users::AssignKey,
      ::Users::Persist,
    ])
  end
end