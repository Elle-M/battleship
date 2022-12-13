require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

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
    p '----- Welcome to BATTLESHIP -----' 
    p 'Enter p to play. Enter q to quit.'
    if gets.chomp.downcase == "p"
    setup
    elsif gets.chomp.downcase == 'q'
      quit
    else
      p 'Please enter p to play or enter q to quit.'
    end
  end

  def setup
    comp_place_ships
    player_place_ships
    turn
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
    puts @comp_board.render(show_ships = true) #delete this
  end

  def player_place_ships
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(show_ships = false)
    p "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp.upcase.split
    until @player_board.valid_placement?(@player_cruiser, user_input) == true
      # require 'pry'; binding.pry
      p "Those are invalid coordinates. Please try again:"
      user_input = gets.chomp.upcase.split
    end
    @player_board.place(@player_cruiser, user_input)
    puts @player_board.render(show_ships = true)
    p "Enter the squares for the Submarine (2 spaces):"
    user_input = gets.chomp.upcase.split
    until @player_board.valid_placement?(@player_sub, user_input) == true
      # require 'pry'; binding.pry
      p "Those are invalid coordinates. Please try again:"
      user_input = gets.chomp.upcase.split
    end
    @player_board.place(@player_sub, user_input)
    puts @player_board.render(show_ships = true) 
  end

  def turn
    until @player_cruiser.sunk? && @player_sub.sunk? || @comp_cruiser.sunk? && @comp_sub.sunk?
    puts "=============COMPUTER BOARD============="
    puts @comp_board.render(show_ships = true) #make false for real game.
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(show_ships = true)
    puts "Enter the coordinate for your shot:"

    user_shot = gets.chomp.upcase
    #require 'pry'; binding.pry
    if @comp_board.valid_coordinate?(user_shot) && @comp_board.cells[user_shot].fired_upon? == false
        @comp_board.cells[user_shot].fire_upon
        puts 'Firing!'
    else
      puts 'Please enter a valid coordinate:'
      user_shot = gets.chomp.upcase
      @comp_board.valid_coordinate?(user_shot) && @comp_board.cells[user_shot].fired_upon? == true
        @comp_board.cells[user_shot].fire_upon
      #puts @comp_board.render(show_ships = false)
    end
     comp_shot
     puts "=============COMPUTER BOARD============="
     puts @comp_board.render(show_ships = false) #make false for real game.
     puts "==============PLAYER BOARD=============="
     puts @player_board.render(show_ships = true)
     puts computer_results(@cpu_shot)

  #   #display both boards - done 
  #   #player fire on one coordinate -done 
  #   #cpu choosing a coordinate to fire on. - done
  #   #report result of players shot.
  #   #report result of cpu shot. 
  end
  end

  def comp_shot
    cpu_shot = @player_board.cells.keys.sample
    until @player_board.cells[cpu_shot].fired_upon? == false
      cpu_shot = @player_board.cells.keys.sample
    end
    @player_board.cells[cpu_shot].fire_upon
    cpu_shot
  end

   def player_results(user_shot)
    if @comp_board.cells[@user_shot].render == "M"
      puts "The shot on #{@user_shot} was a miss."
    elsif @comp_board.cells[@user_shot].render == "H"
      puts "The shot on #{@user_shot} was a hit!"
    elsif @comp_board.cells[@user_shot].render == "X"
      puts "The shot on #{@user_shot} sunk my ship!"
    end
    turn
   end

   def computer_results(cpu_shot)
    if @player_board.cells[@cpu_shot].render == "M"
      puts "The shot on #{@cpu_shot} was a miss."
    elsif @player_board.cells[@cpu_shot].render == "H"
      puts "The shot on #{@cpu_shot} was a hit!"
    elsif @player_board.cells[@cpu_shot].render == "X"
      puts "The shot on #{@cpu_shot} sunk your ship!"
    end
    player_results(@user_shot)
   end
end
    
 
    #find method to put in commas
    # if user_input == @player_board.valid_placement?(@player_cruiser, user_input)
    #   @player_board.place(@player_cruiser, user_input)
    # else user_input != @player_board.valid_placement?(@player_cruiser, user_input) 
    #   p "Those are invalid coordinates. Please try again:"
    # end
    # puts @player_board.render(show_ships = true)

  
game = Game.new
game.start
# require 'pry'; binding.pry
#   Functionality Checklist

# This checklist summarizes all of the functionality you are expected to build. This will be used to assess the completion of your project:

# Main Menu:


# Turn:

# User board is displayed showing hits, misses, sunken ships, and ships
# Computer board is displayed showing hits, misses, and sunken ships
# Computer chooses a random shot
# Computer does not fire on the same spot twice
# User can choose a valid coordinate to fire on
# Entering invalid coordinate prompts user to enter valid coordinate
# Both computer and player shots are reported as a hit, sink, or miss
# User is informed when they have already fired on a coordinate
# Board is updated after a turn
# End Game:

# Game ends when all the user’s ships are sunk
# Game ends when all the computer’s ships are sunk
# Game reports who won
# Game returns user back to the Main Menu
