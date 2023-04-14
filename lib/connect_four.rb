class Board
  attr_reader :board, :player_one, :player_two

  def initialize(col_count = 7, row_count = 6, player_one = 'You', player_two = 'Computer')
    @board = Array.new(col_count) { Array.new(row_count, ' ') }
    @player_one = Player.new(player_one, "\u26AA")
    @player_two = Player.new(player_two, "\u26AB")
    @current_player = @player_one
  end

  def play
    moves = player_input
    # verify_input
    select_move(moves)
    change_turn
  end

  def player_input
    puts 'Please chose an empty cell:'
    input = gets.chomp!
    until valid_input?(input)
      puts "Please enter two valid numbers between 1-#{@board.size} & 1-#{@board[0].size} seperated by a single space:"
      input = gets.chomp!
    end
    moves = input.split(' ')
    [moves[0].to_i, moves[1].to_i]
  end

  def valid_input?(input)
    moves = input.split(' ')
    max_col = @board.size
    max_row = @board[0].size
    is_within_range = moves[0].to_i.between?(1, max_col) && moves[1].to_i.between?(1, max_row)
    return false if moves.size != 2
    return true if  is_within_range && valid_move?(moves)

    false
  end

  def valid_move?(moves)
    col = moves[0].to_i - 1
    row = moves[1].to_i - 1
    @board[col][row] == ' '
  end

  def select_move(move, player = @current_player)
    col = move[0] - 1
    row = move[1] - 1
    player.moves.push(move)
    @board[col][row] = player.sign
  end

  def change_turn
    case @current_player
    when @player_one
      @current_player = @player_two
    when @player_two
      @current_player = @player_one
    end
  end
end

class Player
  attr_reader :name, :sign, :moves
  def initialize(name, sign)
    @name = name
    @sign = sign
    @moves = []
  end
end
