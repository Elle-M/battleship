class Board
  attr_reader :cells
              
              

  def initialize
    @cells = cells
  end

  def cells 
     {
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
  
  def valid_coordinate?(cell)
      @cells.key?(cell)
  end

  def valid_placement?(ship_type, coordinates)
      ship_type.length == coordinates.length &&
      horizontal_valid_placement?(coordinates)
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

  def consecutive_letter(coordinates) #Will return false for ["A2", "A3", "A4"]
      letter = coordinates.map { |coordinate| coordinate.split('').first.ord}
      letter.each_cons(2).all? { |letter_1, letter_2| letter_2.ord - 1 == letter_1 } #true
  end

  def number_duplicate(coordinates) # - won't run correctly in pry. Says ["A2", "A3", "A4"] eq true for duplicate numbers. should be false. 
      number = coordinates.map { |coordinate| coordinate.split('').last.to_i }
      number.each_cons(2).all? { |num_1, num_2| num_2 - 1 == num_1 } #false
  end
  
end
