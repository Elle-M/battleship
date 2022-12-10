class Board
  attr_reader :board, :cells
              
  def initialize
    @cells = {
    "A1": Cell.new("A1"),
    "A2": Cell.new("A2"),
    "A3": Cell.new("A3"),
    "A4": Cell.new("A4"),
    "B1": Cell.new("B1"),
    "B2": Cell.new("B2"),
    "B3": Cell.new("B3"),
    "B4": Cell.new("B4"),
    "C1": Cell.new("C1"),
    "C2": Cell.new("C2"),
    "C3": Cell.new("C3"),
    "C4": Cell.new("C4"),
    "D1": Cell.new("D1"),
    "D2": Cell.new("D2"),
    "D3": Cell.new("D3"),
    "D4": Cell.new("D4")
  }
  end

#   #def cells 
#     {
#     "A1": Cell.new("A1"),
#     "A2": Cell.new("A2"),
#     "A3": Cell.new("A3"),
#     "A4": Cell.new("A4"),
#     "B1": Cell.new("B1"),
#     "B2": Cell.new("B2"),
#     "B3": Cell.new("B3"),
#     "B4": Cell.new("B4"),
#     "C1": Cell.new("C1"),
#     "C2": Cell.new("C2"),
#     "C3": Cell.new("C3"),
#     "C4": Cell.new("C4"),
#     "D1": Cell.new("D1"),
#     "D2": Cell.new("D2"),
#     "D3": Cell.new("D3"),
#     "D4": Cell.new("D4")
#  # }
#   end
  
  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate.to_sym)
  end

  def valid_placement?(ship, coordinates)
    coordinates.each do |coordinate|
      return false if !valid_coordinate?(coordinate) || !@cells[coordinate.to_sym].empty?
    end
    #need to check empty?
    (ship.length == coordinates.length && horizontal_valid_placement?(coordinates)) ||
    (ship.length == coordinates.length && proper_vertical_placement?(coordinates))
  end

  def duplicate_letter?(coordinates) #Will return true for ["A1", "A2", "A3"] or false ["A1", "B1", "C1"] - both valid placements
    letter = coordinates.map { |coordinate| coordinate.split('').first.ord}
    letter.each_cons(2).all? { |letter_1, letter_2| letter_1 == letter_2 } 
  end

  def number_consecutive?(coordinates) #Will return true for ["A1", "A2", "A3"] or false ["A1"", "B1", "C1] - both valid placements.
    number = coordinates.map { |coordinate| coordinate.split('').last.to_i}
    number.each_cons(2).all? { |num_1, num_2| num_2.to_i - 1 == num_1 } 
  end

  def horizontal_valid_placement?(coordinates) #Returns true for ["A2", "A3", "A4"]
    duplicate_letter?(coordinates) && number_consecutive?(coordinates)
  end

  def consecutive_letter?(coordinates) #Will return false for ["A2", "A3", "A4"]
    letter = coordinates.map { |coordinate| coordinate.split('').first.ord}
    letter.each_cons(2).all? { |letter_1, letter_2| letter_2.ord - 1 == letter_1 } #true
  end

  def number_duplicate?(coordinates) # - returs true for  ["A2", "B2", "C2"] and false for ["A1", "B2", "C3"].
    number = coordinates.map { |coordinate| coordinate.split('').last.to_i }
    number.each_cons(2).all? { |num_1, num_2| num_1 == num_2 } #true
  end

  def proper_vertical_placement?(coordinates)
    consecutive_letter?(coordinates) && number_duplicate?(coordinates) 
  end

  # def overlapping(coordinates)
  #   coordinates.all? do |coordinate|
  #     @cells[coordinate.to_sym].empty?
  #   end
  # end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate.to_sym].place_ship(ship)
      end
  end

  def render(user_ships = false)

  end
end
