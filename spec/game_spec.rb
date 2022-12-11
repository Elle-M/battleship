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
end