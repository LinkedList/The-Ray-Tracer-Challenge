local colors = {}

function colors.color(red, green, blue)
	return { red = red, green = green, blue = blue }
end

function colors.add(a, b)
	return colors.color(a.red + b.red, a.green + b.green, a.blue + b.blue)
end

function colors.subtract(a, b)
	return colors.color(a.red - b.red, a.green - b.green, a.blue - b.blue)
end

function colors.multiply(a, obj)
  if type(obj) == 'number' then
    local num = obj
    return colors.color(a.red * num, a.green * num, a.blue * num)
  end
  if type(obj) == 'table' then
    local b = obj
    -- Hadamard product (Schur product) 
	  return colors.color(a.red * b.red, a.green * b.green, a.blue * b.blue)
  end

  error('Invalid input to colors.multiply: ' .. obj)
end

return colors
