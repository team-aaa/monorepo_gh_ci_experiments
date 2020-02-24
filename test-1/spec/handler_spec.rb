require 'spec_helper'

RSpec.describe Handler do
  specify do
    expect(LOG).to receive(:info).once
    expect(LOG).to receive(:debug).exactly(2).times

    described_class.new({}, {})
  end
end
