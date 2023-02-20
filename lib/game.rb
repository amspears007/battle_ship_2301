class Game
  	attr_reader :user_board, 
								:comp_board, 
								:user_cruiser,
								:user_sub,
								:comp_cruiser,
								:comp_sub

    def initialize
      @user_board = Board.new
      @comp_board = Board.new
			@user_cruiser = Ship.new('Cruiser', 3)
			@user_sub = Ship.new('Submarine', 2)
			@comp_cruiser = Ship.new('Cruiser', 3)
			@comp_sub = Ship.new('Submarine', 2)
			@comp = Computer.new
    end

    def main_menu
      puts "Welcome to BATTLESHIP"
      puts "Enter P to play. Enter Q to quit."
      user_input = gets.chomp
      if user_input.upcase == "P"
        start_game
      else user_input.upcase == "Q"
        quit_game
      end
    end

    def quit_game
      puts "You've exited the game."
			exit!
    end

		def start_game
			@comp.comp_sub_placement(comp_board)
			@comp.comp_cruiser_placement(comp_board)
			puts "I have laid out my ships on the grid."
			puts "You now need to lay out your two ships."
			user_board.render
			puts "Enter the squares for the Cruiser (3 spaces):"
			user_input = gets.chomp.upcase
			# if user_board
		end

		def comp_sub_placement
			random_coord = @comp_board.cells.keys.sample(2)
			until @comp_board.valid_placement?(@comp_sub, random_coord)
				random_coord = @comp_board.cells.keys.sample(2)
			end
			@comp_board.place(@comp_sub, random_coord)
		end
end