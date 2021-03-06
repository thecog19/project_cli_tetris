#to do
#return a score
#implement a player who can make moves
#once that's done we have tetris, sort of. Square tetris. Strtris
#more pieces
#colorize the pieces
#rotation for pieces
#player input and controls
#score system
#refactor, add tests, break into classes
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

  ##display stuff

  def display
    #there's a hidden row the player doesn't see, to allow easier peice insertion. 
    @board.each_with_index do |column, index|
      print column unless index == 0 
      print "\n"
    end
  end

  #core logic

  def piece_done
    #checks to see if the conditions to stop have been met. 
    #if they have, runs solidify, update the game state, check for defeat, and start_piece_conds
    if piece_bottom == 20 || hit_piece? 
      solidify
      update_state
      return "game is over" if defeat? == true 
      start_piece_conds
    end
  end
  
  #moving stuff methods
  def piece_position_update(locations, delta_x, delta_y)
    locations.each do |coords|
      @board[coords[0]][coords[1]] = "_"
    end
    locations.each do |coords|
      @board[coords[0] + delta_x][coords[1] + delta_y] = "X"
    end
  end

  def move_piece_horizontal(direction = "r")
    #moves the piece left or right, assuming no edges
    locations = access_piece
    if direction == "r"
      unless locations.any? {|pair| pair[1] == 9 } #verify you'll be inbounds after movement. 
        piece_position_update(locations,0,1)
      end
    elsif direction == "l"
      unless locations.any? {|pair| pair[1] == 0} #verify you'll be inbounds after movement. 
        piece_position_update(locations,0,-1)
      end
    end
  end

  def move_piece_vertical
    #moves the piece down vertically. 
    @spaces_moved += 1
    locations = access_piece
    piece_position_update(locations,+1,0)
    piece_done
  end

  #? methods

  def row_full?(row)
    #check to see if the row is all O's
    @board[row].all? {|cell| cell == "O"} 
  end

  def defeat?
    @board[0].any? {|cell| cell == "O"}
  end

  def hit_piece?
    bottom_edge = piece_bottom
    #scan the row below, if it hits a piece, stop. 
    @board[bottom_edge + 1].each_with_index do |cell, cell_number|
      if cell == "O" && get_bottom_columns.include?(cell_number) 
        return true
      end
    end
    false
  end

  #destructive methods

  def add_piece(shape = "squ", position)
    #inserts a piece into to the board given the position and shape
    @current_piece = @pieces[shape].dup
    piece_being_added = @current_piece.dup
    row_one = @current_piece[0]
    row_two = @current_piece[1]
    grid_modify(row_one, 0, position) if row_one
    grid_modify(row_two, 1, position) if row_two
  end


  def start_piece_conds
    #resets the piece conditions to allow a new piece
    @current_piece = nil
    @spaces_moved = 0
  end

  def grid_modify(shape,row,offset)
    #makes changes to the board
    shape.each_with_index do |symbol, cell| 
      loc = cell + offset
      @board[row][loc] = symbol
    end
  end

  def update_state
    #updates the state of the board by checking for full rows and clearing them, and then dropping the above row into the below row
    num_cleared = 0
    while row_full?(20)
      @board.pop
      @board.unshift(Array.new(10) {"_"})
      num_cleared += 1
    end
    num_cleared
  end

  def solidify
    #solidifies the pieces
    locations = access_piece
    locations.each do |coords|
      @board[coords[0]][coords[1]] = "O"
    end 
  end

  ##gets methods

  def get_bottom_columns
    #returns an array containing the column values of the piece's bottom row.
    bottom = piece_bottom
    coordinates = access_piece
    columns = []
    coordinates.each do |pair|
      columns.push(pair[1]) if bottom == pair[0]
    end
    columns
  end

  def get_all_columns
    #returns an array containing the all column values
    coordinates = access_piece
    columns = []
    coordinates.each do |pair|
      columns.push(pair[1])
    end
    columns
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
end

boar = Board.new
done_row = Array.new(10) {"O"}
boar.board[20] = done_row
boar.update_state
# boar.add_piece("squ", 3)
# boar.move_piece
# boar.display

