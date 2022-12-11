require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

describe Board do  
  let(:board) { Board.new }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  let(:submarine) { Ship.new("Submarine", 2) }
  describe '#initialize' do
    it 'exists and has attributes' do   
    expect(board).to be_a(Board)
    expect(board.cells.length).to eq(16)
    end
  end

  describe '#valid coordinate?' do
    it 'has valid coordinates' do

    expect(board.valid_coordinate?(:A1)).to be true 
    expect(board.valid_coordinate?(:D4)).to be true
    expect(board.valid_coordinate?(:A5)).to be false
    expect(board.valid_coordinate?(:E1)).to be false
    expect(board.valid_coordinate?(:A22)).to be false
    end
  end

  describe '#valid_placement?' do
    it 'has valid length' do
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
    end

    it 'has consecutive coordinates' do
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    expect(board.valid_placement?(submarine, ["B1", "C1"])).to be true
    expect(board.valid_placement?(cruiser, ["F1", "F2", "F3"])).to be false
    end

    it 'cannot be diagonal' do
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end
  end

  describe '#place' do
    it 'places ships' do
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells[:A1]
      cell_2 = board.cells[:A2]
      cell_3 = board.cells[:A3]
    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_3.ship == cell_2.ship).to be true
    end
  end

  describe '#overlapping' do
    it 'will not overlap' do
      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    end
  end

  describe '#render' do
    it 'can render a game board' do
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      
      no_ships = "  1 2 3 4 \n" +
                  "A . . . . \n" +
                  "B . . . . \n" +
                  "C . . . . \n" +
                  "D . . . . \n"
      
      expect(board.render).to eq(no_ships)
      
      ships_shown = "  1 2 3 4 \n" +
                    "A S S S . \n" +
                    "B . . . . \n" +
                    "C . . . . \n" +
                    "D . . . . \n"

      expect(board.render(true)).to eq(ships_shown)
    end
    
    it 'can render a miss' do 
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])

      cell_1 = board.cells[:A1]
      cell_2 = board.cells[:A2]
      cell_3 = board.cells[:A3]
      cell_4 = board.cells[:B4]
      cell_5 = board.cells[:C1]
      cell_6 = board.cells[:D1]

      cell_4.fire_upon
      
      miss_ship =  "  1 2 3 4 \n" +
                  "A . . . . \n" +
                  "B . . . M \n" +
                  "C . . . . \n" +
                  "D . . . . \n"
      
      expect(board.render).to eq(miss_ship)

      ships_shown_miss = "  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . M \n" +
                        "C S . . . \n" +
                        "D S . . . \n"
      
      expect(board.render(true)).to eq(ships_shown_miss)
    end

    it 'can render a hit' do 
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])

      cell_1 = board.cells[:A1]
      cell_2 = board.cells[:A2]
      cell_3 = board.cells[:A3]
      cell_4 = board.cells[:B4]
      cell_5 = board.cells[:C1]
      cell_6 = board.cells[:D1]

      cell_1.fire_upon
      cell_4.fire_upon
      
      hit_ship =  "  1 2 3 4 \n" +
                  "A H . . . \n" +
                  "B . . . M \n" +
                  "C . . . . \n" +
                  "D . . . . \n"
      
      expect(board.render).to eq(hit_ship)

      ships_shown_hit = "  1 2 3 4 \n" +
                        "A H S S . \n" +
                        "B . . . M \n" +
                        "C S . . . \n" +
                        "D S . . . \n"
      
      expect(board.render(true)).to eq(ships_shown_hit)
    end

    it 'can show a sunk ship' do
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])

      cell_1 = board.cells[:A1]
      cell_2 = board.cells[:A2]
      cell_3 = board.cells[:A3]
      cell_4 = board.cells[:B4]
      cell_5 = board.cells[:C1]
      cell_6 = board.cells[:D1]

      cell_5.fire_upon
      cell_6.fire_upon

      sunk_ship =  "  1 2 3 4 \n" +
                  "A . . . . \n" +
                  "B . . . . \n" +
                  "C X . . . \n" +
                  "D X . . . \n"
      
      expect(board.render).to eq(sunk_ship)

      ships_shown_sunk = "  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C X . . . \n" +
                        "D X . . . \n"
      
      expect(board.render(true)).to eq(ships_shown_sunk)
    end
  end
end  