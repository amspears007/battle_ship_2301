require 'spec_helper'

RSpec.describe Ship do

let(:cruiser) {Ship.new("Cruiser", 3)}

  it 'can initialize' do
    expect(cruiser).to be_instance_of(Ship)
  end

  it 'has attributes' do
    expect(cruiser.name).to eq('Cruiser')
    expect(cruiser.length).to eq(3)
    expect(cruiser.health).to eq(3)
  end

  it 'validates if ship can be sunk' do
    expect(cruiser.sunk?).to eq(false)
    cruiser.hit
    cruiser.hit
    cruiser.hit
    expect(cruiser.sunk?).to eq(true)
  end

  it 'hit reduces health' do
    cruiser.hit
    expect(cruiser.health).to eq(2)
    cruiser.hit
    expect(cruiser.health).to eq(1)
    cruiser.hit
    expect(cruiser.health).to eq(0)
  end
end