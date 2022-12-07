class Cell
  attr_reader :coordinate, 
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?  
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end
  
  def fired_upon?
    @fired_upon
  end

  def fire_upon 
    @fired_upon = true
    @ship.hit unless @ship.nil?
  end

  def render(user_ships = false) 
    if user_ships && !fired_upon? && @empty == false && @ship.sunk? == false
       return "S"
    end 
      if !fired_upon?
        "."
      elsif @fired_upon == true && @empty == true
        "M"
      elsif @fired_upon == true && @empty == false && @ship.sunk? == false
        "H"
      elsif @ship.sunk? == true
        "X"
      end
  end
end