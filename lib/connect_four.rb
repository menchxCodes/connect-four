class Board
  attr_reader :board, :player_one, :player_two

  def initialize(col_count = 7, row_count = 6, player_one = 'You', player_two = 'Computer')
    @board = Array.new(col_count) { Array.new(row_count, ' ') }
    @player_one = Player.new(player_one, "\u26AA")
    @player_two = Player.new(player_two, "\u26AB")
    @current_player = @player_one
  end

  def play
    move = player_input
    verify_input
    select_move(@current_player, move)
  end

  def player_input
    puts 'Please chose an empty cell:'
    input = gets.chomp!
    until valid_input?(input)
      puts "Please enter two valid numbers between 1-#{@board.size} & 1-#{@board[0].size} seperated by a single space:"
      input = gets.chomp!
    end
    input
  end

  def valid_input?(input)
    moves = input.split(' ')
    max_col = @board.size
    max_row = @board[0].size
    return false if moves.size != 2
    return true if moves[0].to_i.between?(1, max_col) && moves[1].to_i.between?(1, max_row)

    false
  end

  def verify_input
  end

  def select_move(player, move)
  end
end

class Player
  def initialize(name, sign)
    @name = name
    @sign = sign
    @moves = []
  end
end
