require 'list'
require 'node'

RSpec.describe List do

    describe '#is_empty?' do
        context 'when head and tail are both nil' do
            it 'returns true' do
                list = List.new
                expect(list.is_empty?).to be true
            end
        end

        context 'when either head or tail is not nil' do
            it 'returns false' do
                list = List.new
                node = Node.new("Fluidly", "innovative", nil, nil)
                list.head = node
                expect(list.is_empty?).to be false
            end
        end
    end

    describe '#append' do
        context 'when adding a node to the list'do
            context 'if the list is empty' do
                it 'assigns node to both head and tail' do
                    list = List.new
                    node = Node.new("Fluidly", "innovative", nil, nil)
                    expect(list.append(node)).to eq("#{node} is the head node in the list")
                end
            end

            context 'if the list is not empty' do
                list = List.new
                existing_node = Node.new("Heidi", "passionate", nil, nil)
                list.head = existing_node
                list.tail = existing_node
                new_node = Node.new("Fluidly", "innovative", nil, nil)
                it 'assigns node to tail' do
                    expect(list.append(new_node)).to eq("#{new_node} is the tail node in the list")
                end
            end
        end
    end

    describe '#remove' do
        context 'when removing a node from a list' do
            context 'when node is nil' do
                it 'returns an error - nothing to remove' do
                    list = List.new
                    existing_node = Node.new("Fluidly", "innovative", nil, nil)
                    list.head = existing_node
                    list.tail = existing_node
                    node = nil
                    expect(list.remove(node)).to eq("either node is nil or list is empty")
                end
            end

            context 'when list is empty' do
                it 'returns an error - nothing to remove' do
                    list = List.new
                    node = Node.new("Fluidly", "innovative", nil, nil)
                    expect(list.remove(node)).to eq("either node is nil or list is empty")
                end
            end

            context 'when node to remove is the only node in the list' do
                it 'sets the head and the tail of the list to nil' do
                    list = List.new
                    node = Node.new("Fluidly", "innovative", nil, nil)
                    list.head = node
                    list.tail = node
                    expect(list.remove(node)).to eq("#{node} is removed from the list, the list is now empty")
                    expect(node.next_node).to eq(nil)
                    expect(node.prev_node).to eq(nil)
                end
            end

            context 'when there are more than 1 node in the list and node to remove is the head' do
                it 'removes the node from the head and make the next node to head' do
                    list = List.new
                    old_head_node = Node.new("Heidi", "passionate", nil, nil)
                    new_head_node = Node.new("Fluidly", "innovative", nil, nil)
                    list.head = old_head_node
                    old_head_node.next_node = new_head_node
                    expect(list.remove(old_head_node)).to eq("#{old_head_node}(head) is removed from the list")
                    expect(list.head).to eq(new_head_node)
                    expect(old_head_node.next_node).to eq(nil)
                    expect(old_head_node.prev_node).to eq(nil)
                end
            end

            context 'when the node is neither the head or the tail in the list' do
                it 'removes the node from the middle and connect previous node and next node' do
                    list = List.new
                    middle_node = Node.new("Heidi", "passionate", nil, nil)
                    previous_node = Node.new("Fluidly", "innovative", nil, nil)
                    next_node = Node.new("Shafali", "brilliant", nil, nil)
                    list.head = previous_node
                    list.tail = next_node
                    previous_node.next_node = middle_node
                    middle_node.prev_node = previous_node
                    next_node.prev_node = middle_node
                    middle_node.next_node = next_node
                    expect(list.remove(middle_node)).to eq("#{middle_node} is removed from the list")
                    expect(list.head).to eq(previous_node)
                    expect(list.tail).to eq(next_node)
                    expect(list.head.next_node).to eq(list.tail)
                    expect(middle_node.next_node).to eq(nil)
                    expect(middle_node.prev_node).to eq(nil)
                end
            end
        end 
    end

    describe '#move_back' do
        context 'when the node exists in the list' do
            it 'removes it from where it was and moves it to the end of the list' do
                list = List.new
                node_to_move = Node.new("Heidi", "passionate", nil, nil)
                previous_node = Node.new("Fluidly", "innovative", nil, nil)
                next_node = Node.new("Shafali", "brilliant", nil, nil)
                list.head = previous_node
                list.tail = next_node
                node_to_move.prev_node = previous_node
                previous_node.next_node = node_to_move
                node_to_move.next_node = next_node
                next_node.prev_node = previous_node

                list.move_back(node_to_move)
                
                expect(list.head).to eq(previous_node)
                expect(list.head.prev_node).to eq(nil)
                expect(list.head.next_node).to eq(next_node)

                expect(list.tail).to eq(node_to_move)
                expect(list.tail.prev_node).to eq(next_node)
                expect(list.tail.next_node).to eq(nil)
            end
        end
    end
end

