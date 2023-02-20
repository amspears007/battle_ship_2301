class Setup
  	attr_reader :user_board, :comp_board

    def initialize
      @user_board = Board.new
      @comp_board = Board.new
    end

    def main_menu
      puts "Welcome to BATTLESHIP
      Enter P to play. Enter Q to quit."
      user_input = gets.chomp
      if user_input == "P"
        start_game
      else user_input == "Q"
        quit_game
      end
    end

    def quit_game
      puts "You've exited the game."
			exit!
    end

		def start_game
			puts "I have laid out my ships on the grid.
			You now need to lay out your two ships.
			The Cruiser is three units long and the Submarine is two units long."
			
		end
end