require 'spec_helper'

RSpec.describe Board do
  it 'initializes' do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end
end