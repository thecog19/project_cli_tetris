require 'test'

describe Test do
  describe "#test_func" do
    it "does things" do
      expect(Test.new.test_func).to eq(8)
    end
  end
end 