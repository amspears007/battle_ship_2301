require 'spec_helper'

RSpec.describe Game do
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
    game = Game.new
    game.new_game
    game.comp_sub_placement
    expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
  end

  it 'displays welcome message at beginning of game' do
      game = Game.new
      game.new_game

      expected = "Welcome to =*BATTLESHIP*= \n" +
			"=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*= \n" +
      "Enter P to play. Enter Q to quit."

      expect(game.display_main_menu).to eq(expected) 
    end

    it 'displays message that ships need to be placed' do
      game = Game.new
      game.new_game

      expected = "========================================= \n" +
			"I have laid out my ships on the grid. \n" +
			"You now need to lay out your two ships. \n" +
			"========================================= \n" +
			"Here is my board:" 

      expect(game.display_place_ships_message).to eq(expected)
    end

    it 'allows placement of computer cruiser' do
        game = Game.new
        game.new_game
        game.comp_cruiser_placement
        expect(game.comp_board.render(true) == game.comp_board.render).to be(false)
    end


    it 'creates response for ship that gets hit' do
        game = Game.new
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A1"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
        # require 'pry'; binding.pry
        # expect(game.shot_response_player(user_input)).to eq("Your shot on A1 was a hit!")
    end

    it 'creates response for impact that misses the ship' do
        game = Game.new
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["D4"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["D4"].fire_upon
        # expect(game.shot_response_player(user_input)).to eq("Your shot on D4 was a miss!")
    end

    it 'creates response when opponents ship has sunk' do
        game = Game.new
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        user_sub = game.user_sub
        user_input = comp_board.cells["A3"].coordinate
        comp_board.place(user_cruiser, ["A1", "A2", "A3"])
		comp_board.cells["A1"].fire_upon
        comp_board.cells["A2"].fire_upon
        comp_board.cells["A3"].fire_upon
        # expect(game.shot_response_player(user_input)).to eq("The opponent's ship has sunk!")
    end

    it 'new_game clears all info from previous game' do
        game = Game.new
        game.new_game
        comp_board = game.comp_board
        user_cruiser = game.user_cruiser
        print comp_board.render(true)
        # comp_board.place(user_cruiser, ["A1", "A2", "A3"])
        # # require 'pry'; binding.pry
        # game.new_game
        # print comp_board.render(true)
    end
end
