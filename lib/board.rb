class Board
  attr_reader :cells
              
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
  
  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate.to_sym)
  end

  def valid_placement?(ship, coordinates)
    coordinates.each do |coordinate|
      return false if !valid_coordinate?(coordinate) || !@cells[coordinate.to_sym].empty?
    end
    (ship.length == coordinates.length && horizontal_valid_placement?(coordinates)) ||
    (ship.length == coordinates.length && proper_vertical_placement?(coordinates))
  end

  def duplicate_letter?(coordinates) 
    letter = coordinates.map { |coordinate| coordinate.split('').first.ord }
    letter.each_cons(2).all? { |letter_1, letter_2| letter_1 == letter_2 } 
  end

  def number_consecutive?(coordinates) 
    number = coordinates.map { |coordinate| coordinate.split('').last.to_i }
    number.each_cons(2).all? { |num_1, num_2| num_2.to_i - 1 == num_1 } 
  end

  def horizontal_valid_placement?(coordinates)
    duplicate_letter?(coordinates) && number_consecutive?(coordinates)
  end

  def consecutive_letter?(coordinates)
    letter = coordinates.map { |coordinate| coordinate.split('').first.ord }
    letter.each_cons(2).all? { |letter_1, letter_2| letter_2.ord - 1 == letter_1 } 
  end

  def number_duplicate?(coordinates) 
    number = coordinates.map { |coordinate| coordinate.split('').last.to_i }
    number.each_cons(2).all? { |num_1, num_2| num_1 == num_2 } 
  end

  def proper_vertical_placement?(coordinates)
    consecutive_letter?(coordinates) && number_duplicate?(coordinates) 
  end

  def place(ship, coordinates)
    coordinates.each { |coordinate| @cells[coordinate.to_sym].place_ship(ship) }
  end

  def render(show_ships = false)
    rows = (@cells.values.map { |cell| cell.render(show_ships)}).join(' ')
   
    a_row = rows.slice(0..7)
    b_row = rows.slice(8..15)
    c_row = rows.slice(16..23)
    d_row = rows.slice(24..33)
  
    string_a = "A ,\n"
    string_b = "B ,\n"
    string_c = "C ,\n"
    string_d = "D , \n"
  
    "  1 2 3 4 \n" +
    "#{string_a.gsub(",", a_row)}" + 
    "#{string_b.gsub(",", b_row)}" +
    "#{string_c.gsub(",", c_row)}" +
    "#{string_d.gsub(",", d_row)}"
  end
end

