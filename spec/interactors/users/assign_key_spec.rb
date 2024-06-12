require 'rails_helper'

RSpec.describe Users::AssignKey do
  subject { described_class.call(attributes: {}) }

  describe '.call' do
    it 'assigns a key' do
      expect(subject.attributes[:key]).to be_present
    end
  end
end