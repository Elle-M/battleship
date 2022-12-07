require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'

describe Board do
  let(:cells) { { cell_1: "A1",
                      cell_2: "A2",
                      cell_3: "A3",
                      cell_4: "A4",
                      cell_5: "A1",
                      cell_6: "A2",
                      cell_7: "A3",
                      cell_8: "A4",
                      cell_9: "A1",
                      cell_10: "A2",
                      cell_11: "A3",
                      cell_12: "A4",
                      cell_13: "A1",
                      cell_14: "A2",
                      cell_15: "A3",
                      cell_16: "A4"
                } }
    let(:board) { Board.new(cells) }

  describe '#initialize' do
    it 'exists and has attributes' do   
    expect(board).to be_a(Board)
    expect(board.cells.length).to eq(16)
    end
  end
end  