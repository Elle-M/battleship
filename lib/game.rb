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
    @comp_player(#put ships here)
    @player(#put ships here)
  end

  def start
    p 'Welcome to BATTLESHIP' 
    p 'Enter p to play. Enter q to quit.'
    
    if gets.chomp.downcase == "p"
      run_game
    elsif gets.chomp.downcase == 'q'
      quit
    else
      p 'Please enter p to play or enter q to quit.'
    end
  end

  def run_game
# Computer can place ships randomly in valid locations
      @comp_board
      #comp_player(@comp_ships)
      #comp_player.comp_board.place.rand

#       I have laid out my ships on the grid.
# You now need to lay out your two ships.
# The Cruiser is three units long and the Submarine is two units long.
#   1 2 3 4
# A . . . .
# B . . . .
# C . . . .
# D . . . .
# Enter the squares for the Cruiser (3 spaces): player.board.place
#player(player_ships)

# User can enter valid sequences to place both ships
# Entering invalid ship placements prompts user to enter valid placements
  end

  def comp_player(ships)

  end
end
game = Game.new
game.start
require 'pry'; binding.pry
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
