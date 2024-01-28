local tuples = require("./tuples")
local tuple = tuples.tuple
local point = tuples.point
local add = tuples.add
local subtract = tuples.subtract
local vector = tuples.vector
local negate = tuples.negate
local say = require("say")
local assertions = require("./assertions")
local num_eq = assertions.num_eq
local tuple_eq = assertions.tuple_eq

say:set("assertion.num_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.num_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "num_eq", num_eq, "assertion.num_eq.positive", "assertion.num_eq.negative")

say:set("assertion.tuple_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.tuple_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "tuple_eq", tuple_eq, "assertion.tuple_eq.positive", "assertion.tuple_eq.negative")

describe('A tuple:', function()
	it('with w=1.0 is a point', function()
		local a = tuple(4.3, -4.2, 3.1, 1.0)

		assert.True(a.x == 4.3)
		assert.True(a.y == -4.2)
		assert.True(a.z == 3.1)
		assert.True(a.w == 1.0)
		assert.True(a.isPoint)
		assert.False(a.isVector)
	end)

	it('with w=0 is a vector', function()
		local a = tuple(4.3, -4.2, 3.1, 0.0)

		assert.True(a.x == 4.3)
		assert.True(a.y == -4.2)
		assert.True(a.z == 3.1)
		assert.True(a.w == 0.0)
		assert.False(a.isPoint)
		assert.True(a.isVector)
	end)

	it('point creates tuples with w=1', function()
		local p = point(4, -4, 3)
		assert.are.same(p, tuple(4, -4, 3, 1))
	end)

	it('vector creates tuples with w=0', function()
		local p = vector(4, -4, 3)
		assert.are.same(p, tuple(4, -4, 3, 0))
	end)

	it('numbers are equal to a degree of EPSILON', function()
		assert.num_eq(4.3, 4.300000001)
	end)

	it('tuples are equal', function()
		assert.tuple_eq(point(4, -4.000000001, 3), tuple(4, -4, 3, 1))
	end)
end)

describe('Tuple features:', function()
	it('Adding two tuples', function()
		a1 = tuple(3, -2, 5, 1)
		a2 = tuple(-2, 3, 1, 0)

		local result = add(a1, a2)
		assert.tuple_eq(result, tuple(1, 1, 6, 1))
	end)

	it('Subtracting two points', function()
		a1 = point(3, 2, 1)
		a2 = point(5, 6, 7)

		local result = subtract(a1, a2)
		assert.tuple_eq(result, vector(-2, -4, -6))
	end)

	it('Subtracting vector from a point', function()
		p = point(3, 2, 1)
		v = vector(5, 6, 7)

		local result = subtract(p, v)
		assert.tuple_eq(result, point(-2, -4, -6))
	end)

	it('Subtracting two vectors', function()
		v1 = vector(3, 2, 1)
		v2 = vector(5, 6, 7)

		local result = subtract(v1, v2)
		assert.tuple_eq(result, vector(-2, -4, -6))
	end)

	it('Subtracting a vector from the zero vector', function()
		zero = vector(0, 0, 0)
		v = vector(1, -2, 3)

		local result = subtract(zero, v)
		assert.tuple_eq(result, vector(-1, 2, -3))
	end)

	it('Negating a tuple', function()
		t = tuple(1, -2, 3, -4)

		local result = negate(t)
		assert.tuple_eq(result, tuple(-1, 2, -3, 4))
	end)
end)

