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
    
        game.comp_sub_placement
        expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
    end

    it 'allows placement of computer cruiser' do
        game = Game.new
    
        game.comp_cruiser_placement
        expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
    end
end
