require "tetris"

describe Board do
  let(:instance) {Board.new}
  describe "#board" do
    it "has a 10 by 22 board" do
      expect(Board.new.board).to eq(Array.new(21){Array.new(10) {"_"}})
    end
  end

  describe "#add_peice" do 
    it "takes an input and makes it the current piece" do
      instance.add_piece("squ", 0)
      testcase = Array.new(10) {"_"}
      testcase[0] = "X"
      testcase[1] = "X"
      expect(instance.current_piece).to eq([["X","X"],["X","X"]])
    end

    it "takes an input and adds it to the top of the board" do
      instance.add_piece("squ", 0)
      testcase = Array.new(10) {"_"}
      testcase[0] = "X"
      testcase[1] = "X"
      expect(instance.board[0]).to match_array(testcase)
    end

    it "accepts an horizontal adjustment" do
      instance.add_piece("squ", 3)
      testcase = Array.new(10) {"_"}
      testcase[3] = "X"
      testcase[4] = "X"
      expect(instance.board[0]).to eq(testcase)
    end
  end

  describe "#move_piece_vertical" do
    it "it moves the piece down a level" do
      instance.add_piece("squ", 0)
      instance.move_piece_vertical
      testcase = Array.new(10) {"_"}
      testcase[0] = "X"
      testcase[1] = "X"
      expect(instance.board[2]).to match_array(testcase)
    end

    it "deletes the previous level" do
      instance.add_piece("squ", 0)
      instance.move_piece_vertical
      expect(instance.board[0]).to match_array(Array.new(10) {"_"})
    end

    it "increases spaces moved by 1" do
      instance.add_piece("squ", 0)
      expect{instance.move_piece_vertical}.to change{instance.spaces_moved}.by(1)
    end
  end

  describe "#piece_done" do
    it "sets current peice to none after it hits the bottom" do
      instance.add_piece("squ", 0)
      19.times {instance.move_piece_vertical}
      expect(instance.piece_done).to be_nil
    end

    it "replaces X's with O's" do
      instance.add_piece("squ", 0)
      19.times {instance.move_piece_vertical}
      testcase = Array.new(10) {"_"}
      testcase[0] = "O"
      testcase[1] = "O"
      expect(instance.board[20]).to match_array(testcase)
    end

    it "detects if we've hit another piece" do
      instance.board[20][0] = "O"
      instance.board[19][0] = "O"
      instance.board[20][1] = "O"
      instance.board[19][1] = "O"
      instance.add_piece("squ", 0)
      17.times {instance.move_piece_vertical}
      testcase = Array.new(10) {"_"}
      testcase[0] = "O"
      testcase[1] = "O"
      expect(instance.board[18]).to match_array(testcase)
    end

    it "checks if we've lost the game" do 
      close_row = Array.new(10) {"O"}
      close_row[4] = "_"
      instance.board.map! {|row| row = close_row}
      instance.board[0]
      allow(instance).to receive(:hit_piece?).and_return(true)
      expect(instance.piece_done).to eq("game is over")
    end
  end

  describe "#row_full?" do
    it "returns true when a row is full" do 
      done_row = Array.new(10) {"O"}
      instance.board[20] = done_row
      expect(instance.row_full?(20)).to be true
    end

    it "retruns false when it isn't!" do
      done_row = Array.new(10) {"O"}
      done_row[5] = "_"
      instance.board[20] = done_row
      expect(instance.row_full?(20)).to be false
    end

  end

  describe "#row_delete" do
    it "detects when one row is full and deletes it" do
      done_row = Array.new(10) {"O"}
      testcase = Array.new(10) {"_"}
      instance.board[20] = done_row
      instance.update_state
      expect(instance.board[20]).to eq(testcase)
    end

    it "detects when more than one row is full and deletes them" do
      done_row = Array.new(10) {"O"}
      testcase = Array.new(10) {"_"}
      instance.board[20] = done_row
      instance.board[19] = done_row.dup
      instance.update_state
      expect(instance.board[20]).to eq(testcase)
    end

    it "returns number of rows deleted" do
      done_row = Array.new(10) {"O"}
      instance.board[20] = done_row
      instance.board[19] = done_row.dup
      expect(instance.update_state).to eq(2)
    end
    it "moves all the rows down a level when a row is deleted" do
      weird_row = Array.new(10) {"O"}
      weird_row[5] = "_"
      done_row = Array.new(10) {"O"}
      instance.board[20] = done_row
      instance.board[19] = done_row.dup
      instance.board[18] = weird_row
      instance.update_state
      expect(instance.board[20]).to eq(weird_row)
    end
  end

  describe "#move_piece_horizontal" do
    it "moves the piece to the right" do
      instance.add_piece("squ", 0)
      instance.move_piece_horizontal("r")
      testcase = Array.new(10) {"_"}
      testcase[1],testcase[2] = "X", "X"
      expect(instance.board[1]).to eq(testcase)
    end

    it "moves the piece to the left" do
      instance.add_piece("squ", 5)
      instance.move_piece_horizontal("l")
      testcase = Array.new(10) {"_"}
      testcase[4],testcase[5] = "X", "X"
      expect(instance.board[1]).to eq(testcase)
    end
  end
end