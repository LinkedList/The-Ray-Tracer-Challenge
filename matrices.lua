local module = {}
local tuple = require('./tuples').tuple
local inspect = require('inspect')

-- multiplies only 4x4 matrices :shrug:
function module.multiply(a, b)
  -- if b isn't a matrix we are multiplying by a tuple
  if type(b) == 'table' and type(b[1]) ~= 'table' then
    local result = {}
    for row=1,4 do
      result[row] = 
      a[row][1] * b.x +
      a[row][2] * b.y +
      a[row][3] * b.z +
      a[row][4] * b.w
    end
    return tuple(result[1], result[2], result[3], result[4])
  end

  -- initialize empty 4x4 matrix :shrug:
  local result = {
    {},
    {},
    {},
    {},
  }

  for row=1,4 do
    for col=1,4 do
      result[row][col] = 
      a[row][1] * b[1][col] +
      a[row][2] * b[2][col] +
      a[row][3] * b[3][col] +
      a[row][4] * b[4][col]
    end
  end

  return result
end

-- 4x4 identity matrix`
function module.identity()
  return {
    {1, 0, 0, 0},
    {0, 1, 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1},
  }
end

-- 4x4 matrix transpose
function module.transpose(a)
  local result = {
    {},
    {},
    {},
    {},
  }

  for row=1,4 do
    for col=1,4 do
      result[row][col] = a[col][row]
    end
  end

  return result
end

-- determinant for a 2x2 matrix
function module.determinant(a)
  return a[1][1] * a[2][2] - a[1][2] * a[2][1]
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function module.submatrix(a, row, col)
  local result = deepcopy(a)

  table.remove(result, row)

  for i in pairs(result) do
    table.remove(result[i], col)
  end

  return result
end

function module.minor(a, row, col)
  local sub = module.submatrix(a, row, col)
  return module.determinant(sub)
end

return module
