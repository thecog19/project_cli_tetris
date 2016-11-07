#to do
#delete done rows
#return a score
#define lose state
#implement a player who can make moves
#once that's done we have tetris, sort of. Square tetris. Strtris
#more pieces
#rotation for pieces
#player input and controls
#score system
#music
#realtime functionality
#try curse gem

class Board
  attr_accessor :board
  attr_accessor :current_piece
  attr_accessor :spaces_moved
  def initialize(board = nil)
    @board = board || Array.new(21){Array.new(10) {"_"}} 
    @pieces = {"squ" => [["X","X"],["X","X"]]}
    @current_piece = nil
    @spaces_moved = 0
  end

  def display
    #there's a hidden row the player doesn't see, to allow easier peice insertion. 
    @board.each_with_index do |column, index|
      print column unless index == 0 
      print "\n"
    end
  end

  def add_piece(shape = "squ", position)
    #inserts a piece into to the board given the position and shape
    @current_piece = @pieces[shape].dup
    piece_being_added = @current_piece.dup
    row_one = @current_piece[0]
    row_two = @current_piece[1]
    grid_modify(row_one, 0, position) if row_one
    grid_modify(row_two, 1, position) if row_two
  end

  def move_piece_vertical
    #moves the piece down vertically. 
    @spaces_moved += 1
    locations = access_piece
    locations.each do |coords|
       @board[coords[0]][coords[1]] = "_"
       @board[coords[0] + 1][coords[1]] = "X"
    end
    piece_done
  end

  def piece_done
    #checks to see if the conditions to stop have been met. 
    #if they have, runs solidify and start_piece_conds
    if piece_bottom == 20 || hit_piece? 
      solidify
      start_piece_conds
    end
  end

  private

  def grid_modify(shape,row,offset)
    #makes changes to the board
    shape.each_with_index do |symbol, cell| 
      loc = cell + offset
      @board[row][loc] = symbol
    end
  end

  def access_piece
  #returns an array of arrays with the exact coordinates
  list_of_coords = []
    @board.reverse.each_with_index do |array, row|
      array.each_with_index do |entry, cell|
        if entry == "X"
          list_of_coords.push([20-row, cell])
        end
      end
    end
    list_of_coords
  end

  def piece_bottom
    #finds the bottom row the piece
    piece = access_piece
    bot_row = -1
    piece.each do |coord_pair|
      if coord_pair[0] > bot_row
        bot_row = coord_pair[0]
      end
    end
    bot_row      
  end

  def start_piece_conds
    #resets the piece conditions to allow a new piece
    @current_piece = nil
    @spaces_moved = 0
  end

  def solidify
    #solidifies the pieces
    locations = access_piece
    locations.each do |coords|
      @board[coords[0]][coords[1]] = "O"
    end 
  end

  def row_full?

  end

  def get_columns
    #returns an array containing the column values of the piece
    coordinates = access_piece
    columns = []
    coordinates.each do |pair|
      columns.push(pair[1])
    end
    columns
  end

  def hit_piece?
    bottom_edge = piece_bottom
    #scan the row below, if horizontal coord of any O == coord of any X then stop
    @board[bottom_edge + 1].each_with_index do |cell, cell_number|
      if cell == "O" && get_columns.include?(cell_number)
        puts "We returned true"
        return true
      end
    end
    false
  end
end

# boar = Board.new

# boar.add_piece("squ", 3)
# boar.move_piece
# boar.display

