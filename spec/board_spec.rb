require 'spec_helper'

RSpec.describe Board do
  it 'initializes' do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end

  it 'creates cells in a hash upon initiating' do
    board = Board.new
    expect(board.cells).to be_instance_of(Hash)
    expect(board.cells.keys.length).to eq(16)
    expect(board.cells.values.length).to eq(16)
    expect(board.cells['A1']).to be_instance_of(Cell)
  end

  it 'validates coordinates on the board' do
    board = Board.new
    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("D4")).to eq(true)
    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
  end

  it 'validates placements of ships on the board' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
  end

  it 'makes sure coordinates are consecutive on the board' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.consecutive_order?(["A1", "A2", "A4"])).to eq(false)
    expect(board.consecutive_order?(["A1", "C1"])).to eq(false)
    expect(board.consecutive_order?(["A3", "A2", "A1"])).to eq(false)
    expect(board.consecutive_order?(["C1", "B1"])).to eq(false)

    expect(board.consecutive_order?(["B2", "B3", "B4"])).to eq(true)
    expect(board.consecutive_order?(["C1", "C2"])).to eq(true)
    expect(board.consecutive_order?(["C3", "D3"])).to eq(true)

    expect(board.valid_placement?(cruiser, ["B2", "B3", "B4"])).to eq(true)
    expect(board.valid_placement?(submarine, ["C1", "C2"])).to eq(true)
    expect(board.valid_placement?(submarine, ["C3", "D3"])).to eq(true)
  end

  it 'makes sure coordinates are not diagonal on the board' do
    board = Board.new

    expect(board.consecutive_order?(["A1", "B2", "C3"])).to eq(false)
    expect(board.consecutive_order?(["C2", "D3"])).to eq(false)
  end

  it 'makes sure coordinates are valid on the board' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    expect(board.valid_placement?(submarine, ["E1", "E2"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to eq(true)
    expect(board.valid_placement?(submarine, ["$$", "##"])).to eq(false)
  end

end