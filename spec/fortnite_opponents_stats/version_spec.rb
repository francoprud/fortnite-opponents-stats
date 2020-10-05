RSpec.describe FortniteOpponentsStats do
  let(:version) { described_class::VERSION }

  it 'has the correct version number' do
    expect(version).to eq '0.1.0'
  end
end
