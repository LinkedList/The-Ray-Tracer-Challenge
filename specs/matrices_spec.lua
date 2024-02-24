local assertions = require("./assertions")
local num_eq = assertions.num_eq
local matrix_eq = assertions.matrix_eq
local say = require("say")

say:set("assertion.num_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.num_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "num_eq", num_eq, "assertion.num_eq.positive", "assertion.num_eq.negative")

say:set("assertion.matrix_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.matrix_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "matrix_eq", matrix_eq, "assertion.matrix_eq.positive", "assertion.matrix_eq.negative")

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
