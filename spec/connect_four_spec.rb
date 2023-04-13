require './lib/connect_four'
describe Board do
  describe '#initialize' do
    subject(:game_board) { described_class.new(7,6) }
    it 'board has the correct # of columns' do
      expect(game_board.size).to eq(7)
    end

    it 'board has the correct # of rows' do
      expect(game_board[0].size).to eq(6)
    end

    matcher :be_clear do
      match { |cell| cell == ' ' }
    end
    it 'board is clear' do
      all_cells = game_board.flatten
      
      expect(all_cells).to all(be_clear)
    end
  end
end
