class Node
    attr_accessor :key, :value, :prev_node, :next_node, :read_count

    def initialize(key, value, prev_node, next_node)
        @key = key
        @value = value
        @prev_node = prev_node
        @next_node = next_node
        @read_count = 0
    end
end

