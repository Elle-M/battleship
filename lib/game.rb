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
    p 'Welcome to BATTLESHIP' 
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
  end
  
  # def comp_coords
  #   @comp_board. && @comp_cruiser.length || @comp_sub.length
  # # require 'pry'; binding.pry
  # end

  def valid_comp_coord(ship)
    coordinates = []
    until @comp_board.valid_placement?(ship, coordinates)
        coordinates = @comp_board.cells.keys.map do |key|
          key.to_s
        end.sample(ship.length) 
    end
    coordinates
    
  end

  def comp_place_ships
    ships = [@comp_cruiser, @comp_sub]
    ships.each do |ship| 
      coordinates = valid_comp_coord(ship) 
      @comp_board.place(ship, coordinates)  
    end
    puts @comp_board.render(show_ships = true)
  end

  def player_place_ships
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(show_ships = false)
    p "Enter the squares for the Cruiser (3 spaces):"
    user_input = gets.chomp.upcase.split
  if user_input == valid_placement(ship, coordinates)
  end
  end


  
end
  
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
