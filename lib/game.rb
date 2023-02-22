class Game
  	attr_reader :user_board, 
								:comp_board, 
								:user_cruiser,
								:user_sub,
								:comp_cruiser,
								:comp_sub

    def initialize
      @user_board = nil
      @comp_board = nil
			@user_cruiser = nil
			@user_sub = nil
			@comp_cruiser = nil
			@comp_sub = nil
    end

		def display_main_menu
			"Welcome to =*BATTLESHIP*= \n" +
			"=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*= \n" +
      "Enter P to play. Enter Q to quit."
		end

    def main_menu
			new_game
      put display_main_menu
      user_input = gets.chomp
      if user_input.upcase == "P"
        start_game
			elsif user_input.upcase == "Q"
        quit_game
      else 
				user_input.upcase != "P" || user_input.upcase != "Q"
				puts "Invalid input, try again."
				main_menu
      end
    end

		def new_game
			@user_board = Board.new
      @comp_board = Board.new
			@user_cruiser = Ship.new('Cruiser', 3)
			@user_sub = Ship.new('Submarine', 2)
			@comp_cruiser = Ship.new('Cruiser', 3)
			@comp_sub = Ship.new('Submarine', 2)
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
				puts "Here is your board. Place your ships:"
				puts "========================================="
				print user_board.render
				puts "Enter the squares for the Cruiser (example: A1 A2 A3):"
			user_input = gets.chomp.upcase
				puts "==============PLAYER BOARD=============="
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
				puts "==============PLAYER BOARD=============="
					@user_board.place(@user_sub, user_input.split)
					print @user_board.render(true)
					puts "Congratulations! Let's =*BATTLE(ship)*="
					turns
		end

		def turns
			puts "=============COMPUTER BOARD============="
			print comp_board.render
			puts "==============PLAYER BOARD=============="
			print user_board.render(true)
			puts "Enter the coordinate for your shot:"
			until user_cruiser.sunk? && user_sub.sunk? || comp_cruiser.sunk? && comp_sub.sunk?
				user_input = gets.chomp.upcase
				until comp_board.valid_coordinate?(user_input)
					puts "Please enter a valid coordinate" 
					puts "(example: A1-D4):"
					user_input = gets.chomp.upcase
				end
				if comp_board.cells[user_input].fired_upon?
					puts "=============COMPUTER BOARD============="
					print comp_board.render
					puts "You already fired at that coordinate"
					puts "TURN LOST..."
				else comp_board.cells[user_input].fired_upon? == false 
				comp_board.cells[user_input].fire_upon
				puts "=============COMPUTER BOARD============="
				print comp_board.render
				end
				random_coord = user_board.cells.keys.sample(1)[0] 
				until user_board.cells[random_coord].fired_upon?	== false	
				random_coord = user_board.cells.keys.sample(1)[0] 
				end
				user_board.cells[random_coord].fire_upon
				puts "==============PLAYER BOARD=============="
				print user_board.render(true)
				print shot_response_comp(random_coord)
				puts "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
				print shot_response_player(user_input)
				puts "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
			end
			end_game
		end

		def shot_response_player(user_input)
			# require 'pry'; binding.pry
			if @comp_board.cells[user_input].render == "H"
				puts "Your shot on #{user_input} was a hit!"
				puts "Enter the coordinate for your shot:"
			elsif
				@comp_board.cells[user_input].render == "M" 
				puts "Your shot on #{user_input} was a miss!"
				puts "Enter the coordinate for your shot:"
			else
				@comp_board.cells[user_input].render == "X"
				puts "The opponent's ship has sunk!"
				if @comp_cruiser.sunk? && comp_sub.sunk?
					puts "Congratulations!"
				else @comp_cruiser.sunk? || comp_sub.sunk?
					puts "Enter the coordinate for your shot:"
				end
			end
		end

		def shot_response_comp(random_coord)
			if @user_board.cells[random_coord].render == "H"
				puts "Opponent's shot on #{random_coord} was a hit!"
			elsif
				@user_board.cells[random_coord].render == "M" 
				puts "Opponent's shot on #{random_coord} was a miss!"
			else
				@user_board.cells[random_coord].render == "X"
				puts "The opponent has sunk your ship!"
				if @user_cruiser.sunk? && @user_sub.sunk?
					puts "All your ships have sunk!"
				else @user_cruiser.sunk? || @user_sub.sunk?
				end
			end
		end
		
		def end_game
			if @comp_cruiser.sunk? && comp_sub.sunk?
				puts "You Won!"
				puts "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
			else
				@user_cruiser.sunk? && @user_sub.sunk?
				puts "You lost..."
				puts "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
			end
			main_menu
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