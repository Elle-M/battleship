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
      #require 'pry'; binding.pry
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
    end

    it 'cannot be diagonal' do
      #require 'pry'; binding.pry
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end
  end
end  