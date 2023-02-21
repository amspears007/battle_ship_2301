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
   if ship.length == 3 
      consecutive_order_cruiser?(coordinates) && 
      coordinates.all? do |coordinate|
      @cells[coordinate].empty? == true 
      end
    else
        consecutive_order_sub?(coordinates) && 
        coordinates.all? do |coordinate|
          # require 'pry'; binding.pry
        @cells[coordinate].empty? == true
      end
    end
  end

  def consecutive_order_sub?(coordinates)
    coordinates.each_cons(2).all? do |cell_1, cell_2|
      cell_1[0] == cell_2[0] && 
      cell_2[-1].to_i - 1 == cell_1[-1].to_i || cell_1[-1] == cell_2[-1] && 
      cell_2[0].ord - 1 == cell_1[0].ord
    end  
  end

  def consecutive_order_cruiser?(coordinates)
    coordinates.each_cons(3).all? do |cell_1, cell_2, cell_3|
      cell_1[0] == cell_2[0] && 
      cell_2[0] == cell_3[0] &&
      cell_2[-1].to_i - 1 == cell_1[-1].to_i &&
      cell_3[-1].to_i - 1 == cell_2[-1].to_i || cell_1[-1] == cell_2[-1] &&
      cell_2[-1] == cell_3[-1] &&
      cell_3[0].ord - 1 == cell_2[0].ord &&
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
    if !visible
    cell_values.map do |cell_value|
      rendered_cells << cell_value.render
    end
      "  1 2 3 4 \n" +
      "A #{rendered_cells[0, 4].join(' ')} \n" +
      "B #{rendered_cells[4, 4].join(' ')} \n" + 
      "C #{rendered_cells[8, 4].join(' ')} \n" +
      "D #{rendered_cells[12, 4].join(' ')} \n"
    else
      cell_values.map do |cell_value|
        rendered_cells << cell_value.render(true)
      end
      "  1 2 3 4 \n" +
      "A #{rendered_cells[0, 4].join(' ')} \n" +
      "B #{rendered_cells[4, 4].join(' ')} \n" + 
      "C #{rendered_cells[8, 4].join(' ')} \n" +
      "D #{rendered_cells[12, 4].join(' ')} \n"
    end
  end
end