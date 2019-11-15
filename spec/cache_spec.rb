require 'list'
require 'cache'

RSpec.describe Cache do
    describe '#reset' do
        it 'resets cache' do
            cache = Cache.new(3, 2)
            cache.reset
            expect(cache.num_items).to eq(0)
            expect(cache.cache_hash).to eq({})
            expect(cache.list.head).to eq(nil)
            expect(cache.list.tail).to eq(nil)
        end
    end

    describe '#get' do
        context 'key exists in the cache and' do
            context 'has been read more than 5 times' do
                it 'removes the key from the cache' do
                    cache = Cache.new(3,5)
                    cache.set("Fluidly", "innovative")
                    cache.set("Heidi", "passionate")
                    5.times { cache.get("Fluidly") }
                    expect(cache.get("Fluidly")).to eq("Fluidly has been read 5 times, removed from the cache")
                    expect(cache.num_items).to eq(1)
                    expect(cache.list.head).to eq(cache.cache_hash["Heidi"])
                    expect(cache.list.tail).to eq(cache.cache_hash["Heidi"])
                    expect(cache.cache_hash).to eq({"Heidi" => cache.list.head})
                end
            end

            context 'has not been read more than 5 times' do
                it 'returns the value' do
                    cache = Cache.new(3,5)
                    cache.set("Fluidly", "innovative")
                    cache.set("Heidi", "passionate")
                    3.times { cache.get("Fluidly") }
                    expect(cache.get("Fluidly")).to eq("HIT: retrieved Fluidly - innovative")
                    expect(cache.num_items).to eq(2)
                    expect(cache.list.head).to eq(cache.cache_hash["Heidi"])
                    expect(cache.list.tail).to eq(cache.cache_hash["Fluidly"])
                    expect(cache.cache_hash).to eq({"Heidi" => cache.list.head, "Fluidly" => cache.list.tail})
                end
            end
        end

        context 'key does not exist in the cache' do
            it "returns an error that key does't exist in the cache" do
                cache = Cache.new(3, 5)
                cache.set("Fluidly", "innovative")
                expect(cache.get("Heidi")).to eq("MISS: Heidi doesn't exist in the cache")
            end
        end
    end

    describe '#set' do
        context 'when key exists in the cache' do
            it 'overwrites the value and set the read count to zero' do
                cache = Cache.new(3, 5)
                cache.set("Fluidly", "innovative")
                cache.set("Heidi", "passionate")
                cache.set("Fluidly", "intelligent")
                expect(cache.num_items).to eq(2)
                expect(cache.list.head).to eq(cache.cache_hash["Heidi"])
                expect(cache.list.tail).to eq(cache.cache_hash["Fluidly"])
                expect(cache.cache_hash["Fluidly"].value).to eq("intelligent")
                expect(cache.cache_hash["Fluidly"].read_count).to eq(0)
            end
        end

        context "when key doesn't exist" do
            it "creates a new node add it to the cache" do
                cache = Cache.new(3,5)
                cache.set("Fluidly", "innovative")
                expect(cache.get("Fluidly")).to eq("HIT: retrieved Fluidly - innovative")
                expect(cache.num_items).to eq(1)
                expect(cache.list.head).to eq(cache.cache_hash["Fluidly"])
                expect(cache.list.tail).to eq(cache.cache_hash["Fluidly"])
                expect(cache.cache_hash["Fluidly"].value).to eq("innovative")
                expect(cache.cache_hash["Fluidly"].read_count).to eq(1)
            end
        end

        context 'after adding a new item' do
            context 'when number of items in the cache is more than the capacity' do
                it 'removes the item from the cache' do
                    cache = Cache.new(2, 3)
                    cache.set("Heidi", "passionate")
                    cache.set("Fluidly", "innovative")
                    cache.set("Shafali", "brilliant")
                    expect(cache.num_items).to eq(2)
                    expect(cache.list.head).to eq(cache.cache_hash["Fluidly"])
                    expect(cache.cache_hash["Heidi"]).to eq(nil)
                    
                end
            end
            context 'when number of items in the cache is not more than the capacity' do
                it "doesn't remove the item from the cache" do
                    cache = Cache.new(4, 3)
                    cache.set("Fluidly", "innovative")
                    cache.set("Heidi", "passionate")
                    cache.set("Shafali", "brilliant")
                    expect(cache.num_items).to eq(3)
                    expect(cache.list.head).to eq(cache.cache_hash["Fluidly"])
                    expect(cache.list.tail).to eq(cache.cache_hash["Shafali"])
                    expect(cache.cache_hash["Fluidly"].value).to eq("innovative")
                    expect(cache.cache_hash["Heidi"].value).to eq("passionate")
                    expect(cache.cache_hash["Shafali"].value).to eq("brilliant")
                end
            end
        end
    end
end