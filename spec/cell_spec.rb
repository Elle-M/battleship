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

  describe '#fire_upon' do
    it 'can be fired upon' do
      cell = Cell.new('B4')
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      cell.fire_upon

      expect(cruiser.health).to eq(2)
      expect(cell.fired_upon?).to be true
    end
  end

  describe '#render' do
    it 'renders cell status' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      expect(cell_1.fired_upon?).to eq(false)
    end

    it 'renders a miss' do
      cell_1 = Cell.new("B4")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
      expect(cell_1.fired_upon?).to be true
    end 

    it 'renders a hit' do 
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon
      #require 'pry'; binding.pry
      expect(cell_2.render).to eq("H")
    end

    it 'renders sunk' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")

      cruiser.sunk?
      cruiser.hit
      cruiser.hit
      #require 'pry'; binding.pry
      expect(cruiser.sunk?).to be true
      expect(cell_2.render).to eq("X")
      #require 'pry'; binding.pry
    end

    it 'show uses ships' do
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      # cell_2.fire_upon
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq("S")
      # expect(cell_1.fired_upon?).to be true
    end
  end
end