require 'spec_helper'

RSpec.describe Game do

let(:game) {Game.new}
let(:user_board) {Board.new}
let(:comp_board) {Board.new}
let(:user_cruiser) {Ship.new('Cruiser',3)}
let(:user_sub) {Ship.new('Submarine', 2)}
let(:comp_cruiser) {Ship.new('Cruiser', 3)}
let(:comp_sub) {Ship.new('Submarine', 2)}

    it 'initializes' do
        game.new_game
        expect(game).to be_instance_of(Game)
        expect(user_board).to be_instance_of(Board)
        expect(comp_board).to be_instance_of(Board)
    end

    it 'allows placement of computer submarine' do
        game.new_game
        game.comp_sub_placement
        expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
    end

    it 'allows placement of computer cruiser' do
        game.new_game
        game.comp_cruiser_placement
        expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
    end


    it 'creates response for ship that gets hit' do
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A1"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
    end

    it 'creates response for impact that misses the ship' do
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["D4"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["D4"].fire_upon
    end

    it 'creates response when opponents ship has sunk' do
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A3"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
        comp_board.cells["A2"].fire_upon
        comp_board.cells["A3"].fire_upon
    end

    it 'new_game clears all info from previous game' do
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        print comp_board.render(true)
    end
end
