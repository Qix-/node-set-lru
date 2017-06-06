const {EventEmitter} = require('events');

const id = require('object-id');
const LRU = require('lru');

module.exports =
class SetLRU extends EventEmitter {
	constructor(opts) {
		super();
		const self = this;

		this.lru = new LRU(opts);

		this.lru.on('evict', evicted => self.emit('evict', evicted.value));
	}

	hash(obj) {
		return id(obj);
	}

	add(obj) {
		this.lru.set(this.hash(obj), obj);
	}

	remove(obj) {
		this.lru.remove(this.hash(obj));
	}

	contains(obj) {
		return this.lru.keys.indexOf(this.hash(obj).toString()) !== -1;
	}

	clear() {
		this.lru.clear();
	}

	get contents() {
		const result = [];
		for (const key of this.lru.keys) {
			result.push(this.lru.peek(key));
		}

		return result;
	}

	get length() {
		return this.lru.length;
	}
};
