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
end
