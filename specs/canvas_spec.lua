local canvas_module = require("./canvas")
local canvas = canvas_module.canvas
local getWidth = canvas_module.getWidth
local getHeight = canvas_module.getHeight
local write_pixel = canvas_module.write_pixel
local pixel_at = canvas_module.pixel_at

local color_module = require("./colors")
local color = color_module.color

local inspect = require('inspect')

describe("Creating a canvas", function()
  it("Creates a canvas", function()
    local c = canvas(10, 20)

    assert.same(getWidth(c), 10)
    assert.same(getHeight(c), 20)

    for y=1,20 do
      for x=1,10 do
        local pixel = c[y][x]
        assert.same(pixel, color(0, 0, 0))
      end
    end
  end)

  it("Writes a pixel to canvas", function()
    local c = canvas(10, 20)
    local red = color(1, 0, 0)
    
    write_pixel(c, 2, 3, red)

    assert.same(pixel_at(c, 2, 3), red)

  end)
end)
