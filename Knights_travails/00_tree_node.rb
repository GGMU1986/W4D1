class PolyTreeNode
    attr_reader :parent, :children, :value
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        unless parent_node.nil?
            self.parent.children.delete(self) unless self.parent.nil?
            @parent = parent_node
            @parent.children << self unless @parent.children.include?(self)
        else
            @parent = parent_node
        end
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        unless self.children.include?(child_node)
            raise 'Not a child' 
        else
            child_node.parent = nil
        end
    end

    def dfs(target_value)
        return self if self.value == target_value

        self.children.each do |child|
            sub_answer = child.dfs(target_value)
            return sub_answer unless sub_answer.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]

        until queue.empty?
            ele = queue.shift
            return ele if ele.value == target_value
            queue += ele.children
        end
        nil
    end

end


