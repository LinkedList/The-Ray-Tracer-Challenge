local module = {}
local color_module = require("./colors")
local color = color_module.color
local floor = require('math').floor
local mod = require('math').mod

function module.canvas(width, height) 
  mt = {}          -- create the matrix
  for y=1,height do
    mt[y] = {}     -- create a new row
    for x=1,width do
      mt[y][x] = color(0, 0, 0)
    end
  end

  return mt
end

function module.getWidth(canvas)
  return #canvas[1]
end

function module.getHeight(canvas)
  return #canvas
end

function module.pixel_at(canvas, x, y)
  return canvas[y][x]
end

function module.write_pixel(canvas, x, y, color)
  canvas[y][x] = color
end

function scale(num)
  local n = num
  if n > 1.0 then n = 1.0 end
  if n < 0 then n = 0 end
  return math.floor(n * 255 + 0.5) 
end

function module.canvas_to_ppm(canvas)
  -- naive and stupid building for now
  local width = module.getWidth(canvas)
  local height = module.getHeight(canvas)
  local buffer = 'P3\n'
  buffer = buffer .. width .. ' ' .. height .. '\n'
  buffer = buffer .. '255\n'

  for y, line in pairs(canvas) do
    for x, pixel in pairs(line) do
      local red = scale(pixel.red)
      local green = scale(pixel.green)
      local blue = scale(pixel.blue)
      
      if x % 6 == 0 then
        buffer = buffer .. red .. ' ' .. green .. '\n' .. blue
      else
        buffer = buffer .. red .. ' ' .. green .. ' ' .. blue
      end

      
      if x ~= width then buffer = buffer .. ' ' end
    end

    buffer = buffer .. '\n'
  end

  -- new line at the end of file
  buffer = buffer .. '\n'

  return buffer
end

return module
