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
        build_move_tree
    end
   
    def build_move_tree
        queue = [@root_node] #=> [4, 2], [3, 3], [0, 2], [1, 3], [4, 0], [2, 4], [0, 4], [3, 1], [2, 0]
        until queue.empty?
            ele = queue.shift
            # return ele if ele.value == given_pos.value
            pos_children = new_move_positions(ele.value).map {|pos| PolyTreeNode.new(pos)}
            pos_children.each { |node| ele.add_child(node) }
            queue += pos_children
        end
    end

    def new_move_positions(pos)
        valid_positions = KnightPathFinder.valid_moves(pos)
        new_arr = valid_positions.reject {|pos| @considered_positions.include?(pos)}
        @considered_positions += new_arr
        new_arr
    end

    def find_path(end_pos)
        @root_node.bfs(end_pos.value)
    end
end 

kpf = KnightPathFinder.new([0,0])
p kpf.build_move_tree
