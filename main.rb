require './lib/cache'

cache = Cache.new(3, 4)
cache.set("Fluidly", "innovative")
cache.set("Heidi", "passionate")

cache.reset
cache.get("Fluidly")

cache1 = Cache.new(3, 4)
cache1.set("Fluidly", "innovative")
cache1.get("Fluidly")
    
cache2 = Cache.new(1, 3)
cache2.set("Fluidly", "innovative")
cache2.set("Heidi", "passionate")
cache2.get("Fluidly")
cache2.get("Heidi")

cache3 = Cache.new(2, 3)
cache3.set("Fluidly", "innovative")
cache3.set("Heidi", "passionate")
cache3.get("Fluidly")
cache3.get("Heidi")

cache4 = Cache.new(2, 3)
cache4.set("Fluidly", "innovative")
cache4.set("Heidi", "passionate")
cache4.get("Fluidly")
cache4.set("Shafali", "brilliant")
cache4.get("Heidi")



