require 'rspec'
require './lib/ship'


RSpec.describe Ship do
  describe '#initialize' do
    it 'exists and has attributes'
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq('Cruiser')
    expect(cruiser.length).to eq(3)
    expect(cruiser.health).to eq(3)
  end
end