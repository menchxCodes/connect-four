class Board
  attr_reader :board
  def initialize(col_count = 7, row_count = 6)
    @board = Array.new(col_count) { Array.new(row_count, ' ') }
  end
end
