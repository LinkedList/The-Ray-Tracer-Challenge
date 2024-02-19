local assertions = require("./assertions")
local num_eq = assertions.num_eq

say:set("assertion.num_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.num_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "num_eq", num_eq, "assertion.num_eq.positive", "assertion.num_eq.negative")

describe("Constructing and inspecting a matrix", function()
  it("we should be able to construct a 4x4 matrix", function()
    local mstr = [[
    1   |2   |3   |4
    5.5 |6.5 |7.5 |8.5
    9   |10  |11  |12
    13.5|14.5|15.5|16.5
    ]]
    local m = matrix(mstr)

    assert.num_eq(m[1, 1], 1)
    assert.num_eq(m[1, 4], 4)
  end)
end)
