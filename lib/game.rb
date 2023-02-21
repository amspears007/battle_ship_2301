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
    end

    def main_menu
      puts "Welcome to =*BATTLESHIP*="
			puts "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
      puts "Enter P to play. Enter Q to quit."
      user_input = gets.chomp
      if user_input.upcase == "P"
        start_game
			elsif 
				user_input.upcase != "P" || user_input.upcase != "Q"
				puts "Invalid input, try again"
				main_menu
      else user_input.upcase == "Q"
        quit_game
      end
    end

    def quit_game
      puts "You've exited the game."
			exit!
    end

		def start_game
			comp_sub_placement
			comp_cruiser_placement
				puts "========================================="
				puts "I have laid out my ships on the grid."
				puts "You now need to lay out your two ships."
				puts "========================================="
				puts "Here is my board:"
				print comp_board.render
				puts "========================================="
				puts "Place your ships on this board:"
				puts "========================================="
				print user_board.render

				puts "Enter the squares for the Cruiser (example: A1 A2 A3):"
			user_input = gets.chomp.upcase
			# if user_input.upcase == "Q"
			# quit_game
			# else
				until @user_board.valid_placement?(user_cruiser, user_input.split)
					puts "Invalid input, try again in ascending order"
					puts "with A1-D4 (example: A1 A2 A3):"
					user_input = gets.chomp.upcase
				end
					@user_board.place(@user_cruiser, user_input.split)
					print @user_board.render(true)
					puts "Cruiser succesfully placed!"
					puts "Now enter the squares for Submarine (example: B1 B2):"
			user_input = gets.chomp.upcase
				until @user_board.valid_placement?(user_sub, user_input.split)
					puts "Invalid input, try again in ascending order"
					puts "with A1-D4 (example: B1 B2):"
					user_input = gets.chomp.upcase
				end
					@user_board.place(@user_sub, user_input.split)
					print @user_board.render(true)
					puts "Congratulations! Let's =*BATTLE(ship)*="
					turns
			end
		end

		def turns

		end


		def comp_sub_placement
			random_coord = @comp_board.cells.keys.sample(2)
			until @comp_board.valid_placement?(@comp_sub, random_coord)
				random_coord = @comp_board.cells.keys.sample(2)
			end
			@comp_board.place(@comp_sub, random_coord)
		end

		def comp_cruiser_placement
			random_coord = @comp_board.cells.keys.sample(3)
			until @comp_board.valid_placement?(@comp_cruiser, random_coord)
				random_coord = @comp_board.cells.keys.sample(3)
			end
			@comp_board.place(@comp_cruiser, random_coord)
		end
end