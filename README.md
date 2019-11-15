#LRU Cache

##Features of LRU Cache 
* `set` method allows you to set a key and a value in the cache.
* If key already exists in the cache but value is different, the new value will overwrite and sets the read count to be zero.
* `get` method allows you to retreive the value for the searched key if it is stored in the cache.
* when initiating a cache, the first input is the capacity of the number of items to store in the cache and the second input is how many times it can be read.
* when cache is full, it removes the least recently used node from the cache and the new one is added as a most recently used node.
* when the node is more than the number it can be read, it is removed from the cache.

##How to run
`ruby main.go`

##How to run test
`rspec spec`
* `rspec` was used for a testing tool
* not sure if I can use `rspec` on repl.it as the console is ruby, not shell
