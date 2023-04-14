class Board
  attr_reader :board, :player_one, :player_two

  def initialize(col_count = 7, row_count = 6, player_one = 'You', player_two = 'Computer')
    @board = Array.new(col_count) { Array.new(row_count, ' ') }
    @player_one = Player.new(player_one, "\u26AA")
    @player_two = Player.new(player_two, "\u26AB")
    @current_player = @player_one
    @turn = 0
  end

  def play
    max_turn = @board.size * @board[0].size
    until @turn == max_turn || win?
      moves = player_input
      select_move(moves)
      print_board
      if win?
        puts "#{@current_player.name} win(s)!"
        return
      end

      @turn += 1
      if @turn == max_turn
        puts 'draw!'
        return
      end

      change_turn
    end
  end

  def print_board
    output_array = []
    @board[0].each_index do |row|
      output_string = "#{row + 1} |"
      @board.each_index do |col|
        output_string.concat(" #{@board[col][row]} |")
      end
      output_array << output_string
    end
    until output_array.empty?
      puts output_array.pop
      puts '--------------------------------'
    end
    index = 0
    row_guide = '  |'
    while index < board.size
      row_guide.concat(" #{index + 1} |")
      index += 1
    end
    puts row_guide
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

  def win?(player = @current_player)
    column_win? || row_win? || diagonal_win?
  end

  def column_win?(player = @current_player)
    max_col = @board[0].size
    @board.each_index do |col|
      @board[col].each_index do |row|
        is_win = @board[col][row] == player.sign && @board[col][row + 1] == player.sign && @board[col][row + 2] == player.sign && @board[col][row + 3] == player.sign unless row > max_col - 3
        return true if is_win
      end
    end
    false
  end

  def row_win?(player = @current_player)
    max_row = @board.size
    @board.each_index do |col|
      @board[col].each_index do |row|
        is_win = @board[col][row] == player.sign && @board[col + 1][row] == player.sign && @board[col + 2][row] == player.sign && @board[col + 3][row] == player.sign unless col > max_row - 3
        return true if is_win
      end
    end
    false
  end

  def diagonal_win?(player = @current_player)
    max_col = @board[0].size
    max_row = @board.size
    @board.each_index do |col|
      unless col > max_row - 3
        @board[col].each_index do |row|
          if row < max_col - 3
            is_win = @board[col][row] == player.sign && @board[col + 1][row + 1] == player.sign && @board[col + 2][row + 2] == player.sign && @board[col + 3][row + 3] == player.sign

          else
            is_win = @board[col][row] == player.sign && @board[col + 1][row - 1] == player.sign && @board[col + 2][row - 2] == player.sign && @board[col + 3][row - 3] == player.sign

          end
          return true if is_win
        end
      end
    end
    false
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
