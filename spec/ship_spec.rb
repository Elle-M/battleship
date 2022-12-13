require 'rspec'
require './lib/ship'

describe Ship do
  let(:cruiser) { Ship.new("Cruiser", 3) }

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(cruiser.name).to eq('Cruiser')
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end
  end

  describe '#sunk?' do
    it 'has not been sunk by default' do
      expect(cruiser.sunk?).to eq(false)
    end
  end

  describe '#hit' do
    it 'has been hit' do
      cruiser.hit

      expect(cruiser.health).to eq(2)
    end

    it 'has been sunk' do
      cruiser.hit

      expect(cruiser.health).to eq(2)
      expect(cruiser.sunk?).to eq(false)

      cruiser.hit

      expect(cruiser.health).to eq(1)
      expect(cruiser.sunk?).to eq(false)

      cruiser.hit

      expect(cruiser.sunk?).to be true
    end
  end
end
