class Cell
  attr_reader :coordinate, 
              :ship, 
              :empty,
              :impact

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @impact = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @empty = false
    @ship = ship
  end

  def fired_upon?
    @impact
  end

  def fire_upon
    return "try again" if @impact == true 
      @impact = true
      if @empty == false
      @ship.hit
    end
  end

  def render
    return "." if @impact == false
      return "M" if @impact == true && @empty == true
        return "X" if @impact == true && @ship.health == 0
          return "H" if @impact == true && @empty == false
  end
end