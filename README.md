# set-lru [![Travis-CI.org Build Status](https://img.shields.io/travis/Qix-/node-set-lru.svg?style=flat-square)](https://travis-ci.org/Qix-/node-set-lru) [![Coveralls.io Coverage Rating](https://img.shields.io/coveralls/Qix-/node-set-lru.svg?style=flat-square)](https://coveralls.io/r/Qix-/node-set-lru)

Unordered set adapter for [`LRU`](https://npmjs.org/package/lru).


## Usage

Usage is pretty self-explanatory; a lot of the semantics are identical
to `LRU`.

For example, the constructor forwards all arguments to `LRU`'s constructor.

This module exports the following methods:

- `add(obj)` - adds an object to the set
- `remove(obj)` - removes an object from the set
- `contains(obj)` - tests if the set contains an object
- `clear()` - clears the entire set
- `.contents` _(property)_ - an array containing all of the set's elements
- `.length` _(property)_ - the number of elements in the set
- `on(name, fn)` _(from `EventEmitter`)_ - adds event handlers (currently only responds to `'evict'`)
- `hash(obj)` - can be overridden to change how objects are translated to unique keys (usually not called directly)

The `evict` event in this case simply hands you the object that was evicted, as the LRU key is an implementation detail.

## License
Licensed under the [MIT License](http://opensource.org/licenses/MIT).

You can find a copy of it in [LICENSE](LICENSE).
