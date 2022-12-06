require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  describe '#initialize' do
    it 'exists and has attributes' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq('Cruiser')
    expect(cruiser.length).to eq(3)
    expect(cruiser.health).to eq(3)
    end
  end

  describe '#sunk?' do
    it 'has not been sunk by default' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to eq(false)
    end
  end
end
