local assertions = require("./assertions")
local matrices = require("./matrices")
local tuple = require("./tuples").tuple
local multiply = matrices.multiply
local identity = matrices.identity
local transpose = matrices.transpose
local num_eq = assertions.num_eq
local matrix_eq = assertions.matrix_eq
local tuple_eq = assertions.tuple_eq
local say = require("say")

say:set("assertion.num_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.num_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "num_eq", num_eq, "assertion.num_eq.positive", "assertion.num_eq.negative")

say:set("assertion.matrix_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.matrix_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "matrix_eq", matrix_eq, "assertion.matrix_eq.positive", "assertion.matrix_eq.negative")

say:set("assertion.tuple_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.tuple_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "tuple_eq", tuple_eq, "assertion.tuple_eq.positive", "assertion.tuple_eq.negative")

describe("Constructing and inspecting a matrix", function()
  it("we should be able to construct a 4x4 matrix", function()
    local m = {
      {1   ,2   ,3   ,4},
      {5.5 ,6.5 ,7.5 ,8.5},
      {9   ,10  ,11  ,12},
      {13.5,14.5,15.5,16.5}
    }

    assert.num_eq(m[1][1], 1)
    assert.num_eq(m[1][4], 4)
    assert.num_eq(m[2][1], 5.5)
    assert.num_eq(m[2][3], 7.5)
    assert.num_eq(m[3][3], 11)
    assert.num_eq(m[4][1], 13.5)
    assert.num_eq(m[4][3], 15.5)
  end)

  it("we should be able to construct a 2x2 matrix", function()
    local m = {
      {-3, 5},
      {1 , -2}
    }

    assert.num_eq(m[1][1], -3)
    assert.num_eq(m[1][2], 5)
    assert.num_eq(m[2][1], 1)
    assert.num_eq(m[2][2], -2)
  end)

  it("we should be able to construct a 3x3 matrix", function()
    local m = {
      {-3, 5, 0},
      {1 , -2, -7},
      {0 , 1, 1},
    }

    assert.num_eq(m[1][1], -3)
    assert.num_eq(m[2][2], -2)
    assert.num_eq(m[3][3], 1)
  end)
end)

describe("Matrix equality", function()
  it("identical matrices are equal", function()
    local a = {
      {1, 2, 3, 4},
      {5, 6, 7, 8},
      {9, 8, 7, 6},
      {5, 4, 3, 2},
    }

    local b = {
      {1, 2, 3, 4},
      {5, 6, 7, 8},
      {9, 8, 7, 6},
      {5, 4, 3, 2},
    }

    assert.matrix_eq(a, b)
  end)

  it("non-identical matrices are not equal", function()
    local a = {
      {1, 2, 3, 4},
      {5, 6, 7, 8},
      {9, 8, 7, 6},
      {5, 4, 3, 2},
    }

    local b = {
      {2, 3, 4, 5},
      {6, 7, 8, 9},
      {8, 7, 6, 5},
      {4, 3, 2, 1},
    }

    assert.are_not.matrix_eq(a, b)
  end)
end)

describe("Multiplying matrices", function()
  it("by another matrix", function()
    local a = {
      {1, 2, 3, 4},
      {5, 6, 7, 8},
      {9, 8, 7, 6},
      {5, 4, 3, 2},
    }

    local b = {
      {-2, 1, 2,  3},
      { 3, 2, 1, -1},
      { 4, 3, 6,  5},
      { 1, 2, 7,  8},
    }

    local expected = {
      {20, 22,  50,  48},
      {44, 54, 114, 108},
      {40, 58, 110, 102},
      {16, 26,  46,  42},
    }

    local result = multiply(a, b)

    assert.matrix_eq(result, expected)
  end)

  it("by tuple", function()
    local a = {
      {1, 2, 3, 4},
      {2, 4, 4, 2},
      {8, 6, 4, 1},
      {0, 0, 0, 1},
    }

    local b = tuple(1, 2, 3, 1)

    local expected = tuple(18, 24, 33, 1)
    local result = multiply(a, b)
    assert.tuple_eq(result, expected)
  end)

  it("by identity", function()
    local a = {
      {1, 2, 3, 4},
      {2, 4, 4, 2},
      {8, 6, 4, 1},
      {0, 0, 0, 1},
    }

    local b = identity()

    local result = multiply(a, b)
    assert.matrix_eq(result, a)
  end)

  it("identity matrix by a tuple", function()
    local a = identity()
    local b = tuple(18, 24, 33, 1)

    local result = multiply(a, b)
    assert.tuple_eq(result, b)
  end)
end)

describe('Transposing a matrix', function()
  it('transposes a matrix', function()
    local a = {
      {0, 9, 3, 0},
      {9, 8, 0, 8},
      {1, 8, 5, 3},
      {0, 0, 5, 8}
    }

    local result = {
      {0, 9, 1, 0},
      {9, 8, 8, 0},
      {3, 0, 5, 5},
      {0, 8, 3, 8}
    }

    assert.matrix_eq(transpose(a), result)
  end)

  it('transposing identity matrix creates a identity matrix', function()
    local a = identity()

    assert.matrix_eq(transpose(a), identity())
  end)
end)
