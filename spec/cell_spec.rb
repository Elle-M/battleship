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
end