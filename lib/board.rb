class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new('A1'),
      "A2" => Cell.new('A2'),
      "A3" => Cell.new('A3'),
      "A4" => Cell.new('A4'),
      "B1" => Cell.new('B1'),
      "B2" => Cell.new('B2'),
      "B3" => Cell.new('B3'),
      "B4" => Cell.new('B4'),
      "C1" => Cell.new('C1'),
      "C2" => Cell.new('C2'),
      "C3" => Cell.new('C3'),
      "C4" => Cell.new('C4'),
      "D1" => Cell.new('D1'),
      "D2" => Cell.new('D2'),
      "D3" => Cell.new('D3'),
      "D4" => Cell.new('D4')
     }
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.length && 
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end && 
      consecutive_order?(coordinates) && 
      coordinates.all? do |coordinate|
      @cells[coordinate].empty? == true
    end
  end

  def consecutive_order?(coordinates)
    coordinates.each_cons(2).all? do |cell_1, cell_2|
      cell_1[0] == cell_2[0] && 
      cell_2[-1].to_i - 1 == cell_1[-1].to_i || cell_1[-1] == cell_2[-1] && 
      cell_2[0].ord - 1 == cell_1[0].ord
    end  
  end

  def place(ship, coordinates)
    return false if !valid_placement?(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  
  def render(visible = false)
    cell_values = @cells.values.flatten
    rendered_cells = []
    cell_values.map do |cell_value|
      rendered_cells << cell_value.render
    end
    # rendered_cells
      # require 'pry'; binding.pry
      "  1 2 3 4 \nA #{rendered_cells[0, 4].join(' ')} \nB #{rendered_cells[4, 4].join(' ')} \nC #{rendered_cells[8, 4].join(' ')} \nD #{rendered_cells[12, 4].join(' ')} \n"
    
    # @cells.map do |cell|


    #   starter_board = @cells.each_value.map {|cell| cell.render}
    #   # @cells[cell].render
    #   split_board = starter_board.each_slice(4).to_a
    # rendered_board = "  1 2 3 4 \nA #{split_board[0].concat.join(" ")} \nB #{split_board[1].concat.join(" ")} \nC #{split_board[2].concat.join(" ")} \nD #{split_board[3].concat.join(" ")} \n"
    #end
  end
end