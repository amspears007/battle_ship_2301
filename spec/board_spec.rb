require 'spec_helper'

RSpec.describe Board do
  it 'initializes' do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end

  it 'creates cells in a hash upon initiating' do
    board = Board.new
    board.cells
    expect(board.cells).to be_instance_of(Hash)
    expect(board.cells.keys.length).to eq(16)
    expect(board.cells.values.length).to eq(16)
    expect(board.cells['A1']).to be_instance_of(Cell)
  end
end