local canvas_module = require("./canvas")
local canvas = canvas_module.canvas
local getWidth = canvas_module.getWidth
local getHeight = canvas_module.getHeight
local write_pixel = canvas_module.write_pixel
local pixel_at = canvas_module.pixel_at
local canvas_to_ppm = canvas_module.canvas_to_ppm

local color_module = require("./colors")
local color = color_module.color

local inspect = require('inspect')

local function lines(str) 
  local result = {} 
  for line in str:gmatch '[^\n]+' do 
    table.insert(result, line) 
  end 
  return result 
end 

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

  it('Constructing the PPM header', function()
    local c = canvas(5, 3)

    local ppm = canvas_to_ppm(c)
    local ppm_lines = lines(ppm)
    assert.same(ppm_lines[1], 'P3')
    assert.same(ppm_lines[2], '5 3')
    assert.same(ppm_lines[3], '255')
  end)

  it('Constructing the PPM pixel data', function()
    local c = canvas(5, 3)
    local c1 = color(1.5, 0, 0)
    local c2 = color(0, 0.5, 0)
    local c3 = color(-0.5, 0, 1)

    write_pixel(c, 1, 1, c1)
    write_pixel(c, 3, 2, c2)
    write_pixel(c, 5, 3, c3)

    local ppm = canvas_to_ppm(c)
    local ppm_lines = lines(ppm)

    print(inspect(ppm_lines))

    assert.same(ppm_lines[4], '255 0 0 0 0 0 0 0 0 0 0 0 0 0 0')
    assert.same(ppm_lines[5], '0 0 0 0 0 0 0 128 0 0 0 0 0 0 0')
    assert.same(ppm_lines[6], '0 0 0 0 0 0 0 0 0 0 0 0 0 0 255')
  end)
end)
