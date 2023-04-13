require './lib/connect_four'
describe Board do
  describe '#initialize' do
    subject(:game_board) { described_class.new }

    context 'board is created correctly' do
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

    context 'players are initialized correctly' do
      it 'player one is created ' do
        player_one = game_board.instance_variable_get(:@player_one)
        expect(player_one).to be_instance_of(Player)
      end

      it 'player two is created' do
        player_two = game_board.instance_variable_get(:@player_two)
        expect(player_two).to be_instance_of(Player)
      end

      it 'current player is player_one' do
        player_one = game_board.instance_variable_get(:@player_one)
        current_player = game_board.instance_variable_get(:@current_player)
        expect(current_player).to be(player_one)
      end
    end
  end
end
