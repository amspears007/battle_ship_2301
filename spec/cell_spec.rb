require 'spec_helper'

RSpec.describe Cell do 

  it 'can initialize' do
    cell = Cell.new("B4")
    expect(cell).to be_instance_of(Cell)
    expect(cell.coordinate).to eq("B4")
  end

  it 'ship starts nil, cell is empty' do
    cell = Cell.new("B4")
    expect(cell.ship).to eq(nil)
    expect(cell.empty?).to eq(true)
  end

  it 'adds a ship the cell' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.empty?).to eq(false)
    expect(cell.ship).to eq(cruiser)
  end

  it 'can be fired upon if ship is placed' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to eq(false)
    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to eq(true)
  end

  it 'can be fired upon if empty' do
    cell = Cell.new("B4")
    expect(cell.fired_upon?).to eq(false)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
  end
end
