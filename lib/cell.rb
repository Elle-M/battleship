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
    if fired_upon? && empty?
      return "M"
    elsif fired_upon? && !empty? && !ship.sunk? 
      return "H"
    elsif fired_upon? && ship.sunk?
      return "X"
    end
    
    return "S" if user_ships && !empty? 
    
    "."
  end
end