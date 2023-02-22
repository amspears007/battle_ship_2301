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

    it 'creates response based on shots' do
        game = Game.new
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A1"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
        # require 'pry'; binding.pry
        expect(game.shot_response_player(user_input)).to eq("Your shot on A1 was a hit!")
    end

    it 'creates response for ship that gets hit' do
        game = Game.new
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A1"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
        # require 'pry'; binding.pry
        expect(game.shot_response_player(user_input)).to eq("Your shot on A1 was a hit!")
    end

    it 'creates response for impact that misses the ship' do
        game = Game.new
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["D4"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["D4"].fire_upon
        expect(game.shot_response_player(user_input)).to eq("Your shot on D4 was a miss!")
    end

    it 'creates response when opponents ship has sunk' do
        game = Game.new
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A3"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
        comp_board.cells["A2"].fire_upon
        comp_board.cells["A3"].fire_upon
        expect(game.shot_response_player(user_input)).to eq("The opponent's ship has sunk!")
    end
end
