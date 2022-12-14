require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'exists' do 
      expect(game).to be_a(Game)
    end
  end

  describe '#valid_comp_coord' do
    it 'has valid_comp_coord' do
      comp_cruiser = Ship.new("Cruiser", 3)  
      comp_sub = Ship.new("Submarine", 2)
      cells = game.valid_comp_coord(comp_cruiser)
      
      expect(game.valid_comp_coord(comp_cruiser).length).to eq(comp_cruiser.length)
      expect(game.valid_comp_coord(comp_sub).length).to eq(comp_sub.length)
      expect(game.comp_board.valid_placement?(comp_cruiser, cells)).to be true
   end
  end
end
