should = require 'should'

SLRU = require '..'

Error.stackTraceLimit = Infinity

it 'should initialize', ->
	s = new SLRU
	s = new SLRU 10
	s = new SLRU 2
	s = new SLRU maxAge: 10

it 'should add an object', ->
	s = new SLRU
	o = foo: 'bar'
	s.add o
	s.length.should.equal 1
	s.add o
	s.length.should.equal 1
	s.contains(o).should.equal true
	s.contents.should.deepEqual [o]

it 'should remove an object', ->
	s = new SLRU
	o = foo: 'bar'
	s.add o
	s.length.should.equal 1
	s.remove o
	s.length.should.equal 0
	s.contains(o).should.equal false
	s.contents.should.deepEqual []

it 'should not react to unknown objects', ->
	s = new SLRU
	s.length.should.equal 0
	s.remove {}
	s.length.should.equal 0

it 'should handle many objects', ->
	s = new SLRU
	o1 = {}
	o2 = {}
	o3 = {}
	o4 = {}

	s.add o1
	s.add o2
	s.length.should.equal 2
	s.add o1
	s.length.should.equal 2
	s.contents.should.deepEqual [o2, o1]

it 'should clear all objects', ->
	s = new SLRU
	s.add {}
	s.add {}
	s.add {}
	s.add {}
	s.length.should.equal 4
	s.clear()
	s.length.should.equal 0

it 'should evict old values', ->
	s = new SLRU 1
	o1 = foo: 1234
	o2 = foo: 5678

	lastEvicted = null

	s.on 'evict', (obj) -> lastEvicted = obj

	s.add o1
	(should lastEvicted).equal null
	s.add o2
	(should lastEvicted).equal o1
	s.add o2
	(should lastEvicted).equal o1
	lastEvicted = null
	s.add o2
	(should lastEvicted).equal null
	s.add o1
	(should lastEvicted).equal o2
	s.add o2
	(should lastEvicted).equal o1
