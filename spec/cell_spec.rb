require 'rspec'
require './lib/ship'
require './lib/cell'

describe Cell do
  describe '#initialize' do
    it 'exists and has attributes' do
      cell = Cell.new('B4')

    expect(cell).to be_a(Cell)
    expect(cell.coordinate).to eq('B4')
    end

    it 'has empty cell by default' do
      cell = Cell.new('B4')

    expect(cell.ship).to eq(nil)
    expect(cell.empty?).to be true
    end
  end

  describe '#place_ship()' do
    it 'places the ship' do
      cell = Cell.new('B4')
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

    expect(cell.ship.name).to eq("Cruiser")
    expect(cell.empty?).to eq(false)
    end
  end

  describe '#fired_upon?' do
    it 'hasnt been fired upon by default' do
      cell = Cell.new('B4')
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

    expect(cell.fired_upon?).to be false
    end
  end

  describe '#fire_upon'
    it 'can be fired upon' do
      cell = Cell.new('B4')
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      cell.fire_upon

      expect(cruiser.health).to eq(2)
      expect(cell.fired_upon?).to eq true
    end
end