require_relative "00_tree_node.rb"

class KnightPathFinder

    def self.valid_moves(pos)
        moves = []
        moves.push([(pos[0] + 2), (pos[1] + 1)]) #2,1
        moves.push([(pos[0] + 1), (pos[1] + 2)]) #1,2
        moves.push([(pos[0] - 2), (pos[1] + 1)]) #-2,1
        moves.push([(pos[0] - 1), (pos[1] + 2)]) #-1,2
        moves.push([(pos[0] - 2), (pos[1] - 1)]) #-2,-1
        moves.push([(pos[0] - 1), (pos[1] - 2)]) #-1,-2
        moves.push([(pos[0] + 2), (pos[1] - 1)]) #2,-1
        moves.push([(pos[0] + 1), (pos[1] - 2)]) #1,-2

        rows = (0..7).to_a
        cols = (0..7).to_a


        moves.select do |move|
            rows.include?(move[0]) && cols.include?(move[1]) 
        end
        
    end

    def initialize(pos)
        @pos = pos
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
    end
   
    def build_move_tree
        queue = Set[@root_node]
        until queue.empty?
            ele = queue.shift
            # return ele if ele.value == given_pos.value
            pos_children = new_move_positions(ele).map {|pos| PolyTreeNode.new(pos)}
            # pos_children.each { |node| node.parent = ele }
            # ele.children = pos_children
            queue += pos_children
        end
        raise "Given position not accessible from starting position"
    end

    def new_move_positions(pos)
        valid_positions = KnightPathFinder.valid_moves(pos)
        new_arr = valid_positions.reject {|pos| @considered_positions.include?(pos)}
        @considered_positions += new_arr
        new_arr
    end
end 