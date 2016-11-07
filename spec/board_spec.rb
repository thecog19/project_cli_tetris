require "board"

describe Board do
  let(:instance) {Board.new}
  describe "#board" do
    it "has a 10 by 20 board" do
      expect(Board.new.board).to eq(Array.new(21){Array.new(10) {"_"}})
    end
  end

  describe "#add_peice" do 
    it "takes an input and makes it the current piece" do
      instance.add_piece("squ", [0,1])
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
  end

  describe "#move_piece" do
    it "it moves the piece down a level" do
      instance.add_piece("squ", 0)
      instance.move_piece
      testcase = Array.new(10) {"_"}
      testcase[0] = "X"
      testcase[1] = "X"
      expect(instance.board[2]).to match_array(testcase)
    end

    it "deletes the previous level" do
      instance.add_piece("squ", 0)
      instance.move_piece
      expect(instance.board[0]).to match_array(Array.new(10) {"_"})
    end

    it "increases spaces moved by 1" do
      instance.add_piece("squ", 0)
      expect{instance.move_piece}.to change{instance.spaces_moved}.by(1)
    end
  end

  describe "#piece_done" do
    it "sets current peice to none if 20 moves have happened" do
      instance.current_piece = "test"
      instance.spaces_moved = 20
      expect(instance.piece_done).to be_nil
    end

    it "replaces X's with O's" do
      instance.add_piece("squ", 0)
      20.times {instance.move_piece}
      testcase = Array.new(10) {"_"}
      testcase[0] = "O"
      testcase[1] = "O"
      expect(instance.board[20]).to match_array(testcase)
    end
  end
end