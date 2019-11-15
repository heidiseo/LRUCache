require_relative 'list'

class Cache
    attr_accessor :num_items, :capacity, :cache_hash, :list, :ttl
    def initialize(capacity, ttl=5)
        @capacity = capacity
        @ttl = ttl
        self.reset
    end

    def reset
        @num_items = 0
        @cache_hash = {}
        @list = List.new
    end

    def get(key)
        if @cache_hash.key?(key)
            node = @cache_hash[key]
            @list.move_back(node)
            node.read_count += 1
            if node.read_count > @ttl
                @num_items -= 1
                @list.remove(node)
                @cache_hash.delete(key)
                message = "#{key} has been read #{@ttl} times, removed from the cache"
            else
                message = "HIT: retrieved #{key} - #{node.value}"
            end
        else
            message = "MISS: #{key} doesn't exist in the cache"
        end
        puts message
        return message
    end

    def set(key, value)
        if @cache_hash.key?(key)
            node = @cache_hash[key]
            node.value = value
            node.read_count = 0 #refresh read_count as value changed
            @list.move_back(node)
        else
            @num_items += 1
            new_node = Node.new(key, value, nil, nil)
            @list.append(new_node)
            @cache_hash[key] = new_node
            #if we need to evict entry
            if @num_items > @capacity
                @num_items -= 1
                to_remove = @list.head
                @list.remove(to_remove)
                @cache_hash.delete(to_remove.key)
            end
        end
    end


    
end
