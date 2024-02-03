local colors = require("./colors")
local color = colors.color
local add = colors.add
local subtract = colors.subtract
local multiply = colors.multiply
local say = require("say")
local assertions = require("./assertions")
local num_eq = assertions.num_eq

say:set("assertion.num_eq.positive", "Expected %s \nto be equal: %s")
say:set("assertion.num_eq.negative", "Expected %s \nto not be equal: %s")
assert:register("assertion", "num_eq", num_eq, "assertion.num_eq.positive", "assertion.num_eq.negative")

describe("Color are (red, green, blue) tuples", function()
  it("Constructor", function()
    local c = color(-0.5, 0.4, 1.7)

    assert.num_eq(c.red, -0.5)
    assert.num_eq(c.green, 0.4)
    assert.num_eq(c.blue, 1.7)
  end)

  it("Adding colors", function()
    local c1 = color(0.9, 0.6, 0.75)
    local c2 = color(0.7, 0.1, 0.25)

    local result = add(c1, c2)
    assert.num_eq(result.red, 1.6)
    assert.num_eq(result.green, 0.7)
    assert.num_eq(result.blue, 1.0)
  end)

  it("Subtracting colors", function()
    local c1 = color(0.9, 0.6, 0.75)
    local c2 = color(0.7, 0.1, 0.25)

    local result = subtract(c1, c2)
    assert.num_eq(result.red, 0.2)
    assert.num_eq(result.green, 0.5)
    assert.num_eq(result.blue, 0.5)
  end)

  it("Multiplying colors by a scalar", function()
    local c = color(0.2, 0.3, 0.4)

    local result = multiply(c, 2)
    assert.num_eq(result.red, 0.4)
    assert.num_eq(result.green, 0.6)
    assert.num_eq(result.blue, 0.8)
  end)

  it("Multiplying colors", function()
    local c1 = color(1, 0.2, 0.4)
    local c2 = color(0.9, 1, 0.1)

    local result = multiply(c1, c2)
    assert.num_eq(result.red, 0.9)
    assert.num_eq(result.green, 0.2)
    assert.num_eq(result.blue, 0.04)
  end)
end)
