require 'spec_helper'

RSpec.describe Board do

  let(:board) {Board.new}
  let(:cruiser) {Ship.new("Cruiser", 3)}
  let(:submarine) {Ship.new("Submarine", 2)}
  let(:cell_1) {board.cells["A1"]}
  let(:cell_2) {board.cells["A2"]}
  let(:cell_3) {board.cells["A3"]} 
  let(:cell_4) {board.cells["C3"]}
  let(:cell_5) {board.cells["D3"]}
  
  it 'initializes' do
    expect(board).to be_instance_of(Board)
  end

  it 'creates cells in a hash upon initiating' do
    expect(board.cells).to be_instance_of(Hash)
    expect(board.cells.keys.length).to eq(16)
    expect(board.cells.values.length).to eq(16)
    expect(board.cells['A1']).to be_instance_of(Cell)
  end

  it 'validates coordinates on the board' do
    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("D4")).to eq(true)

    expect(board.valid_coordinate?("a1")).to eq(false)
    expect(board.valid_coordinate?("d4")).to eq(false)

    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
    expect(board.valid_coordinate?("Denver, CO")).to eq(false)

    expect(board.valid_coordinate?(["a1"])).to eq(false)
    expect(board.valid_coordinate?(:A1)).to eq(false)
  end

  describe 'valid_placement?' do
    it 'validates placements of ships on the board' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    end
  end

  it 'makes sure coordinates are consecutive on the board' do
    expect(board.consecutive_order_cruiser?(["A1", "A2", "A4"])).to eq(false)
    expect(board.consecutive_order_sub?(["A1", "C1"])).to eq(false)
    expect(board.consecutive_order_cruiser?(["A3", "A2", "A1"])).to eq(false)
    expect(board.consecutive_order_sub?(["C1", "B1"])).to eq(false)

    expect(board.consecutive_order_cruiser?(["B2", "B3", "B4"])).to eq(true)
    expect(board.consecutive_order_sub?(["C1", "C2"])).to eq(true)
    expect(board.consecutive_order_sub?(["C3", "D3"])).to eq(true)

    expect(board.valid_placement?(cruiser, ["B2", "B3", "B4"])).to eq(true)
    expect(board.valid_placement?(submarine, ["C1", "C2"])).to eq(true)
    expect(board.valid_placement?(submarine, ["C3", "D3"])).to eq(true)
  end

  it 'makes sure coordinates are not diagonal on the board' do

    expect(board.consecutive_order_cruiser?(["A1", "B2", "C3"])).to eq(false)
    expect(board.consecutive_order_sub?(["C2", "D3"])).to eq(false)
  end

  it 'makes sure coordinates are valid on the board' do
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    expect(board.valid_placement?(submarine, ["E1", "E2"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to eq(true)
    expect(board.valid_placement?(submarine, ["$$", "##"])).to eq(false)
  end

  it 'places ship on board' do
    expect(cell_1.empty?).to eq(true)
    expect(cell_2.empty?).to eq(true)
    expect(cell_3.empty?).to eq(true)

    board.place(cruiser, ["A1", "A2", "A3"]) 
    expect(board.place(submarine, ["A1", "A2"])).to eq(false)

    expect(cell_1.empty?).to eq(false)
    expect(cell_2.empty?).to eq(false)
    expect(cell_3.empty?).to eq(false)

    expect(cell_1.ship).to be_instance_of(Ship)
    expect(cell_2.ship).to be_instance_of(Ship)
    expect(cell_3.ship).to be_instance_of(Ship)
    expect(cell_2.ship).to eq(cell_3.ship)

    board.place(submarine, ["C3", "D3"])

    expect(cell_4.empty?).to eq(false)
    expect(cell_5.empty?).to eq(false)

    expect(cell_4.ship).to be_instance_of(Ship)
    expect(cell_5.ship).to be_instance_of(Ship)
    expect(cell_4.ship).to eq(cell_5.ship)
  end

  it 'checks for overlapping ships' do   
    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    expect(board.place(submarine, ["A1", "B1"])).to eq(false)
  end

  it 'can render the board' do
    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    board.place(submarine, ["C3", "D3"])

    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n")
  end

  it 'can render the board with ships fired_upon, hit and sunk' do
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["C3", "D3"])

    cell_1.fire_upon
    expect(board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")

    cell_4.fire_upon
    expect(board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . H . \nD . . S . \n")

    cell_5.fire_upon
    expect(board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . X . \nD . . X . \n")
  end
end