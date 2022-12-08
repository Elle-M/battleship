require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

describe Board do  
  let(:board) { Board.new }

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
end  