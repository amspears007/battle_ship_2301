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

  it 'can render a representation of a cell' do
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    expect(cell_1.render).to eq('.')
    cell_1.fire_upon
    expect(cell_1.render).to eq('M')
    expect(cell_2.render).to eq('.')
    cell_2.fire_upon
    expect(cell_2.render).to eq('H')
    cruiser.hit
    cruiser.hit
    expect(cell_2.render).to eq('X')
  end

end
