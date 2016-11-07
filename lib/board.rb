class Board
  attr_accessor :board
  attr_accessor :current_piece
  def initialize(board = nil)
    @board = board || Array.new(21){Array.new(10) {"_"}} 
    @pieces = {"squ" => [["X","X"],["X","X"]]}
    @current_piece = nil
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
    #how to insert piece?
    
  end

  def move_piece

  end
end