require 'spec_helper'

RSpec.describe Cell do 

let(:cell) {Cell.new("B4")}
let(:cell_2) {Cell.new("C3")}
let(:cruiser) {Ship.new("Cruiser", 3)}

  it 'can initialize' do
    expect(cell).to be_instance_of(Cell)
    expect(cell.coordinate).to eq("B4")
  end

  it 'ship starts nil, cell is empty' do
    expect(cell.ship).to eq(nil)
    expect(cell.empty?).to eq(true)
  end

  it 'adds a ship the cell' do
    cell.place_ship(cruiser)
    expect(cell.empty?).to eq(false)
    expect(cell.ship).to eq(cruiser)
  end

  it 'can be fired upon if ship is placed' do
    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to eq(false)

    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to eq(true)
  end

  it 'can be fired upon if empty' do
    expect(cell.fired_upon?).to eq(false)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
  end

  it 'can render a representation of a cell without ship' do
    expect(cell.render).to eq('.')
    cell.fire_upon
    expect(cell.render).to eq('M')
  end

  it 'can render representation of cell with ship' do
    cell_2.place_ship(cruiser)
    expect(cell_2.render).to eq('.')
    expect(cell_2.render(true)).to eq("S")

    cell_2.fire_upon
    expect(cell_2.render).to eq('H')

    cruiser.hit
    cruiser.hit
    expect(cruiser.sunk?).to eq(true)
    expect(cell_2.render).to eq('X')
  end
end
