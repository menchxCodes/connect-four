require './lib/connect_four'
describe Board do
  describe '#initialize' do
    context 'board is created correctly' do
      subject(:game_board) { described_class.new }
      let(:board) { game_board.board }
      it 'board has the correct # of columns' do
        expect(board.size).to eq(7)
      end

      it 'board has the correct # of rows' do
        expect(board[0].size).to eq(6)
      end

      matcher :be_clear do
        match { |cell| cell == ' ' }
      end
      it 'all cells are clear' do
        all_cells = board.flatten
        expect(all_cells).to all(be_clear)
      end
    end
  end
end
