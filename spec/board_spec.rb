require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

describe Board do  
  let(:board) { Board.new }
  let(:crusier) { Ship.new("Cruiser", 3) }
  let(:submarine) { Ship.new("Submarine", 2) }
  
  describe '#initialize' do
    it 'exists and has attributes' do   
    expect(board).to be_a(Board)
    expect(board.cells.length).to eq(16)
    end
  end

  describe '#valid coordinate?' do
    it 'has valid coordinates' do
    expect(board.valid_coordinate?("A1")).to be true 
    expect(board.valid_coordinate?("D4")).to be true
    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end

  describe '#valid_placement?' do
    it 'has valid ship placement' do
    
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    end
  end
end  