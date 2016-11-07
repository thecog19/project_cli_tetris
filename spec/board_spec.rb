require "board"

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
  end

  describe "#row_delete" do
    it "detects when one row is full and deletes it" do
      #this test needs to account for dropdown
      done_row = Array.new(10) {"O"}
      done_row[0] = "_"
      done_row[1] = "_"
      instance.board[20] = done_row
      expect(instance.board[20]).to eq(Array.new(10) {"_"})
    end

    it "detects when more than one row is full and deletes them"

    it "returns number of rows deleted"

    it "moves all the rows down a level when a row is deleted"
  end
  
end