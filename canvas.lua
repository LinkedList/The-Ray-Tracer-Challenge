local canvas_module = {}
local color_module = require("./colors")
local color = color_module.color

function canvas_module.canvas(width, height) 
  mt = {}          -- create the matrix
  for y=1,height do
    mt[y] = {}     -- create a new row
    for x=1,width do
      mt[y][x] = color(0, 0, 0)
    end
  end

  return mt
end

function canvas_module.getWidth(canvas)
  return #canvas[1]
end

function canvas_module.getHeight(canvas)
  return #canvas
end

function canvas_module.pixel_at(canvas, x, y)
  return canvas[y][x]
end

function canvas_module.write_pixel(canvas, x, y, color)
  canvas[y][x] = color
end

return canvas_module
