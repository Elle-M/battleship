class Game 
  attr_reader :comp_board
  def initialize
    @comp_board = Board.new
    @player_board = Board.new
    @comp_cruiser = Ship.new("Cruiser", 3) 
    @comp_sub = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub =  Ship.new("Submarine", 2)
  end

  def start
    puts "----- Welcome to BATTLESHIP -----" 
    puts "Enter p to play. Enter q to quit."
    if gets.chomp.downcase == "p"
      setup
    elsif gets.chomp.downcase == "q"
      quit
    else
      puts "Please enter p to play or enter q to quit."
    end
  end

  def setup
    comp_place_ships
    player_place_ships
    turn
  end

  def quit
    puts "Thank you for playing. Type control + C to exit."
  end

  def valid_comp_coord(ship)
    coordinates = []
    until @comp_board.valid_placement?(ship, coordinates)
    coordinates = @comp_board.cells.keys.sample(ship.length)
    end
    coordinates
  end

  def comp_place_ships
    ships = [@comp_cruiser, @comp_sub]
    ships.each do |ship| 
      coordinates = valid_comp_coord(ship) 
      @comp_board.place(ship, coordinates)  
    end
  end

  def player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(show_ships = false)
    puts "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp.upcase.split
    until @player_board.valid_placement?(@player_cruiser, user_input) == true
      puts "Those are invalid coordinates. Please try again:"
      user_input = gets.chomp.upcase.split
    end
    @player_board.place(@player_cruiser, user_input)
    puts @player_board.render(show_ships = true)
    puts "Enter the squares for the Submarine (2 spaces):"
    user_input = gets.chomp.upcase.split
    until @player_board.valid_placement?(@player_sub, user_input) == true
      puts "Those are invalid coordinates. Please try again:"
      user_input = gets.chomp.upcase.split
    end
    @player_board.place(@player_sub, user_input)
    puts @player_board.render(show_ships = true) 
  end

  def turn
    until @player_cruiser.sunk? && @player_sub.sunk? || @comp_cruiser.sunk? && @comp_sub.sunk?      
      puts "Enter the coordinate for your shot:"
      user_shot = gets.chomp.upcase
      #user_shot = @player_board.cells.keys.sample # - Takes player shot automatically (auto pilot version of game.)
      until @comp_board.valid_coordinate?(user_shot) && @comp_board.cells[user_shot].fired_upon? == false 
        puts "Please enter a valid coordinate:"
        if @comp_board.valid_coordinate?(user_shot) && @comp_board.cells[user_shot].fired_upon? == true 
          puts "You've already selected this coordinate. Try again."
        end
      user_shot = gets.chomp.upcase
      #user_shot = @player_board.cells.keys.sample # - Takes player shot automatically (auto pilot version of game.)
      end
      @comp_board.cells[user_shot].fire_upon
      puts "Firing!"
      player_results(user_shot)
      if @comp_cruiser.sunk? && @comp_sub.sunk?
        puts "=============COMPUTER BOARD============="
        puts @comp_board.render(show_ships = false)

        puts "==============PLAYER BOARD=============="
        puts @player_board.render(show_ships = true)
        return player_win
      end
      puts "=============COMPUTER BOARD============="
      puts @comp_board.render(show_ships = false)
      comp_shot
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(show_ships = true)
    end
    winners_message
  end

  def comp_shot
    cpu_shot = @player_board.cells.keys.sample
    until @player_board.cells[cpu_shot].fired_upon? == false
    cpu_shot = @player_board.cells.keys.sample
    end
    @player_board.cells[cpu_shot].fire_upon
    computer_results(cpu_shot)
  end

  def player_results(user_shot)
    if @comp_board.cells[user_shot].render == "M"
    puts "Your shot on #{user_shot} was a miss."
    elsif @comp_board.cells[user_shot].render == "H"
    puts "Your shot on #{user_shot} was a hit!"
    elsif @comp_board.cells[user_shot].render == "X"
    puts "Your shot on #{user_shot} sunk my ship!"
    end
  end

  def computer_results(cpu_shot)
    if @player_board.cells[cpu_shot].render == "M"
    puts "My shot on #{cpu_shot} was a miss."
    elsif @player_board.cells[cpu_shot].render == "H"
    puts "My shot on #{cpu_shot} was a hit!"
    elsif @player_board.cells[cpu_shot].render == "X"
    puts "My shot on #{cpu_shot} sunk your ship!"
    end
  end

  def player_win
    if @comp_cruiser.sunk? && @comp_sub.sunk?      
      puts "You won!"
    end
  end

  def comp_win
    if @player_cruiser.sunk? && @player_sub.sunk?
      puts "I won!"
    end
  end

  def winners_message
    if player_win == true
    else comp_win
    end
  end
end
  






