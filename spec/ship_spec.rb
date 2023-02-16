require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    it 'can initialize' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser).to be_an_instance(Ship)
    end

    it 'has attributes' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser.name).to eq('Cruiser')
        expect(cruiser.length).to eq(3)
        expect(cruiser.health).to eq(3)
    end
end