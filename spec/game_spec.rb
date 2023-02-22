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

    it 'displays message computer ships have been placed' do
      game = Game.new
      game.new_game

      expected = "========================================= \n" +
			"I have laid out my ships on the grid. \n" +
			"You now need to lay out your two ships. \n" +
			"========================================= \n" +
			"Here is my board:" 

      expect(game.display_comp_place_ships).to eq(expected)
    end

    it 'displays message user needs to place ships' do
      game = Game.new
      game.new_game

      expected = "========================================= \n" +
			"Here is your board. Place your ships: \n" +
			"=========================================" 

      expect(game.display_user_place_ships).to eq(expected)
    end

    it 'displays message user needs to place cruiser' do
      game = Game.new
      game.new_game

      expected = "Enter the squares for the Cruiser (example: A1 A2 A3):"

      expect(game.display_user_cruiser_placement).to eq(expected)
    end

    it 'displays message user needs to place submarine after placing cruiser' do
      game = Game.new
      game.new_game

      expected = "Cruiser succesfully placed! \n" +
			"Now enter the squares for Submarine (example: B1 B2):"

      expect(game.display_user_sub_placement).to eq(expected)
    end

    it "displays message when invalid coordinate is inputted" do
      game = Game.new
      game.new_game

      expected = "Invalid input, try again in ascending order \n" +
			"with A1-D4 (example: A1 A2 A3):"

      expect(game.display_invalid_input).to eq(expected)
    end

    it 'displays message for the player board' do
      game = Game.new
      game.new_game

      expected = "==============PLAYER BOARD=============="

      expected(game.dislay_player_board).to eq(expected)
    end

    it 'displays message for the player board' do
      game = Game.new
      game.new_game

      expected = "=============COMPUTER BOARD============="

      expected(game.dislay_comp_board).to eq(expected)
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
