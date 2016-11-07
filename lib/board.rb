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
    @current_piece = @pieces[shape].dup
    piece_being_added = @current_piece.dup
    row_one = @current_piece[0]
    row_two = @current_piece[1]
    grid_modify(row_one, 0) if row_one
    grid_modify(row_two, 1) if row_two
  end

  def grid_modify(specs,pos)
    specs.each_with_index do |symbol, index| 
      @board[pos][index] = symbol
    end
  end

  def move_piece
    @spaces_moved += 1
    @board.reverse.each_with_index do |array, row|
      array.each_with_index do |entry, cell|
        if entry == "X"
          @board[20-row][cell] = "_" 
          @board[22-row][cell] = "X"
        end
      end
    end
  end
end

boar = Board.new

boar.add_piece("squ", [0,1])
boar.move_piece
boar.display