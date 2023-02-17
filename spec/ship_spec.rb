require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    it 'can initialize' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser).to be_instance_of(Ship)
    end

    it 'has attributes' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser.name).to eq('Cruiser')
        expect(cruiser.length).to eq(3)
        expect(cruiser.health).to eq(3)
    end

    it 'validates if ship can be sunk' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser.sunk?).to eq(false)
        cruiser.hit
        cruiser.hit
        cruiser.hit
        expect(cruiser.sunk?).to eq(true)
    end

    it 'hit reduces health' do
        cruiser = Ship.new("Cruiser", 3)
        cruiser.hit
        expect(cruiser.health).to eq(2)
        cruiser.hit
        expect(cruiser.health).to eq(1)
        cruiser.hit
        expect(cruiser.health).to eq(0)
    end
end