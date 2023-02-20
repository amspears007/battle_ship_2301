require 'spec_helper'

RSpec.describe Game do
    it 'initializes' do
        game = Game.new
        user_board = Board.new
        comp_board = Board.new
        expect(game).to be_instance_of(Game)
        expect(user_board).to be_instance_of(Board)
        expect(comp_board).to be_instance_of(Board)
    end

    # it 'start method creates a main menu' do
    #     game = Game.new
    # end

    it 'allows placement of computer submarine' do
        game = Game.new
        board = Board.new
        comp_board = Board.new
        comp_sub = Ship.new('Submarine', 2)
        # random_coord = board.cells.keys.sample(2)
        # expect(random_coord).to be_instance_of(Array)
        game.comp_sub_placement
        # require 'pry'; binding.pry
        expect(comp_board.valid_placement?(comp_sub, ["A1", "A3"])).to eq(false)
        expect(comp_board.valid_placement?(comp_sub, ["A1", "A2"])).to eq(true)
      end
end