require_relative 'node'

class List
    attr_accessor :head, :tail

    def initialize
        @head = nil
        @tail = nil
    end

    #to check if list is empty
    def is_empty?
        @head == nil && @tail == nil
    end

    #add node to the end of the list
    def append(node)
        if is_empty?
            @head = node
            @tail = node
            return "#{node} is the head node in the list"
        else
            @tail.next_node = node
            node.prev_node = @tail
            @tail = node
            return "#{node} is the tail node in the list"
        end
    end

     #remove the node from the beginning of list
     def remove(node)
        #if node is nil or list is empty
        if node == nil || is_empty?
            return "either node is nil or list is empty"
        #if node is the only one in the list
        elsif node == @head && node == @tail
            @head = nil
            @tail = nil
            message = "#{node} is removed from the list, the list is now empty"
        #if there are more than 1 node and it is the head
        elsif node == @head
            new_head = @head.next_node
            @head.next_node = nil
            new_head.prev_node = nil
            @head = new_head
            message = "#{node}(head) is removed from the list"
        #if node is tail
        elsif node == @tail
            new_tail = @tail.prev_node
            @tail.prev_node = nil
            new_tail.next_node = nil
            @tail = new_tail
            message = "#{node}(tail) is removed from the list"
        #if node is in the middle
        else
            node.prev_node.next_node = node.next_node
            node.next_node.prev_node = node.prev_node
            message = "#{node} is removed from the list"
        end

        if node != nil
            node.next_node = nil
            node.prev_node = nil
        end
        return message
    end

    #move the node to the end of the list
    def move_back(node)
        remove(node)
        append(node)
    end

end