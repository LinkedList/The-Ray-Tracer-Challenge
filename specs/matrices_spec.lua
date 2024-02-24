local assertions = require("./assertions")
local num_eq = assertions.num_eq
local say = require("say")

say:set("assertion.num_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.num_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "num_eq", num_eq, "assertion.num_eq.positive", "assertion.num_eq.negative")

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
end)
