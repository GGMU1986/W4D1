require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    p board
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_board = @board.dup
    @board.each do |row|
      row.each do |ele|
        if ele.empty? && @next_mover_mark == :X
          ele = TicTacToeNode.new(new_board, :O, :X)
        end
      end
    end
  end
end
