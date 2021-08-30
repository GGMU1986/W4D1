require_relative 'tic_tac_toe'
require "byebug"
class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.over? && @board.winner != evaluator
    self.children.all?{|child| child.losing_node?(evaluator)}
    false
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_board = @board.dup
    new_arr = []
    # debugger
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        if @board.empty?([i, j]) 
          if @next_mover_mark == :x
            node = TicTacToeNode.new(new_board, :o, [i, j])
            pos = [i, j]
            node.board[pos] = next_mover_mark
            new_arr << node
          else
            node = TicTacToeNode.new(new_board, :x, [i, j])
            pos = [i, j]
            node.board[pos] = next_mover_mark
            new_arr << node
          end
        end
      end
    end
    new_arr
  end
end
