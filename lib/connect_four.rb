class Board
  attr_reader :board, :player_one, :player_two
  def initialize(col_count = 7, row_count = 6, player_one = 'You', player_two = 'Computer')
    @board = Array.new(col_count) { Array.new(row_count, ' ') }
    @player_one = Player.new( player_one, "\u26AA")
    @player_two = Player.new(player_two, "\u26AB")
    @current_player = @player_one
  end
end

class Player
  def initialize(name, sign)
    @name = name
    @sign = sign
  end
end
