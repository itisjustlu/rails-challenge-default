require 'rails_helper'

RSpec.describe Users::Finder do
  it 'organizes' do
    expect(described_class.organized).to eq([
      Users::Finders::ValidateParams,
      Users::Finders::ByEmail,
      Users::Finders::ByFullName,
      Users::Finders::ByMetadata,
    ])
  end
end
