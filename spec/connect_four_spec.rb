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

  describe '#play' do
    subject(:game_board) { described_class.new }
    before do
      allow(game_board).to receive(:player_input)
      allow(game_board).to receive(:verify_input)
      allow(game_board).to receive(:select_move)
    end

    context "gets current player's input" do
      it 'calls #player_input once' do
        expect(game_board).to receive(:player_input).once
        game_board.play
      end
    end
    context "verifies current player's input" do
      it 'calls #verify_input once' do
        expect(game_board).to receive(:verify_input).once
        game_board.play
      end
    end
    context 'executes the move' do
      it 'calls #select_move once' do
        expect(game_board).to receive(:select_move).once
        game_board.play
      end
    end
  end

  describe '#player_input' do
    subject(:game_board) { described_class.new }
    before do
      allow(game_board).to receive(:puts)
      allow(game_board).to receive(:gets).and_return('2 3')
      allow(game_board).to receive(:valid_input?).and_return(true)
    end
    context 'receives correct input' do
      it 'calls gets method once' do
        expect(game_board).to receive(:gets).once
        game_board.player_input
      end
    end
    context 'receives incorrect input, then correct input' do
      it 'calls gets method twice' do
        allow(game_board).to receive(:valid_input?).and_return(false, true)
        expect(game_board).to receive(:gets).twice
        game_board.player_input
      end
    end
  end

  describe '#valid_input?' do
    subject(:game_board) { described_class.new }
    context 'input is invalid' do
      context 'is more than 2 numbers' do
        it 'returns false' do
          invalid_input = '2 3 4'
          is_valid = game_board.valid_input?(invalid_input)
          expect(is_valid).to eq(false)
        end
      end

      context 'is just one number' do
        it 'returns false' do
          invalid_input = '2'
          is_valid = game_board.valid_input?(invalid_input)
          expect(is_valid).to eq(false)
        end
      end

      context 'includes characters' do
        it 'returns false' do
          invalid_input = 'a2 3'
          is_valid = game_board.valid_input?(invalid_input)
          expect(is_valid).to eq(false)
        end
      end
    end
    context 'input is valid' do
      context 'is two numbers seperated by a single space' do
        it 'retruns true' do
          valid_input = '2 3'
          is_valid = game_board.valid_input?(valid_input)
          expect(is_valid).to eq(true)
        end
      end

      context 'is between the boundries' do
        it '"11 20" returns false' do
          invalid_input = '11 20'
          is_valid = game_board.valid_input?(invalid_input)
          expect(is_valid).to eq(false)
        end

        it '"2 3" returns true' do
          valid_input = '2 3'
          is_valid = game_board.valid_input?(valid_input)
          expect(is_valid).to eq(true)
        end

        context 'edge cases' do
          it '"7 6" returns true' do
            valid_input = '7 6'
            is_valid = game_board.valid_input?(valid_input)
            expect(is_valid).to eq(true)
          end

          it '"8 7" returns false' do
            invalid_input = '8 7'
            is_valid = game_board.valid_input?(invalid_input)
            expect(is_valid).to eq(false)
          end
        end
      end
    end
  end
end
