local module = {}
local color_module = require("./colors")
local color = color_module.color
local floor = require('math').floor
local mod = require('math').mod
local inspect = require('inspect')

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

function newStack ()
  return {}
end

function addString (stack, s)
  table.insert(stack, s)    -- push 's' into the the stack
end

function num_char_len(num)
  if num < 10 then return 1 end
  if num < 100 then return 2 end
  return 3
end

function module.canvas_to_ppm(canvas)
  local width = module.getWidth(canvas)
  local height = module.getHeight(canvas)

  local s = newStack()

  addString(s, 'P3')
  local size = width .. ' ' .. height
  addString(s, size)
  addString(s, '255')
  
  local length = 0;
  local values = {}
  for y, line in pairs(canvas) do
    for x, pixel in pairs(line) do
      local red = scale(pixel.red)
      local green = scale(pixel.green)
      local blue = scale(pixel.blue)
      local colors = {red, green, blue}

      for _, color in pairs(colors) do
        if length + num_char_len(color) > 70 then
          addString(s, table.concat(values, ' '))
          length = 0
          values = {}
        end

        table.insert(values, color)
        -- adding +1 for empty space after 
        length = length + num_char_len(color) + 1
      end
    end

    addString(s, table.concat(values, ' '))
    values = {}
    length = 0
  end

  table.insert(s, '\n')
  -- new line at the end of file
  return table.concat(s, '\n')
end

return module
