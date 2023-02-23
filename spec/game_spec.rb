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
    game = Game.new
    game.new_game
    user_board = Board.new
    comp_board = Board.new
    user_cruiser = Ship.new('Cruiser', 3)
    comp_sub = Ship.new('Submarine', 2)

    expect(game).to be_instance_of(Game)
    expect(user_board).to be_instance_of(Board)
    expect(comp_board).to be_instance_of(Board)
    expect(user_cruiser).to be_instance_of(Ship)
    expect(comp_sub).to be_instance_of(Ship)
  end

  it 'allows placement of computer submarine' do
    game.new_game
    game.comp_sub_placement

    expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
  end

  it 'displays welcome message at beginning of game' do
      game.new_game

      expected = "Welcome to =*BATTLESHIP*= \n" +
			"=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*= \n" +
      "Enter P to play. Enter Q to quit."

      expect(game.display_main_menu).to eq(expected) 
  end

  it 'displays message computer ships have been placed' do
    game.new_game

    expected = "========================================= \n" +
    "I have laid out my ships on the grid. \n" +
    "You now need to lay out your two ships. \n" +
    "========================================= \n" +
    "Here is my board:" 

    expect(game.display_comp_place_ships).to eq(expected)
  end

  it 'displays message user needs to place ships' do
    game.new_game

    expected = "========================================= \n" +
    "Here is your board. Place your ships: \n" +
    "=========================================" 

    expect(game.display_user_place_ships).to eq(expected)
  end

  it 'displays message user needs to place cruiser' do
    game.new_game

    expected = "Enter the squares for the Cruiser (example: A1 A2 A3):"

    expect(game.display_user_cruiser_placement).to eq(expected)
  end

  it 'displays message user needs to place submarine after placing cruiser' do
    game.new_game

    expected = "Cruiser succesfully placed! \n" +
    "Now enter the squares for Submarine (example: B1 B2):"

    expect(game.display_user_sub_placement).to eq(expected)
  end

  it "displays message when invalid coordinate is inputted" do
    game.new_game

    expected = "Invalid input, try again in ascending order \n" +
    "with A1-D4 (example: A1 A2 A3):"

    expect(game.display_invalid_input).to eq(expected)
  end

  it 'displays message for the player board' do
    game.new_game

    expected = "==============PLAYER BOARD=============="

    expect(game.display_player_board).to eq(expected)
  end

  it 'displays message for the player board' do
    game.new_game

    expected = "=============COMPUTER BOARD============="

    expect(game.display_comp_board).to eq(expected)
  end

  it 'allows placement of computer cruiser' do
    game.new_game
    game.comp_cruiser_placement
    expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
  end
end
