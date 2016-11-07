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
      expect(instance.board[0]).to contain_exactly(testcase)
    end
  end
end