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
end