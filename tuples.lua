local tuples = {}
local sqrt = math.sqrt

function tuples.tuple(x, y, z, w)
	local isPoint = w == 1.0
	local isVector = w == 0.0
	return { x = x, y = y, z = z, w = w, isPoint = isPoint, isVector = isVector }
end

function tuples.point(x, y, z)
	return tuples.tuple(x, y, z, 1)
end

function tuples.vector(x, y, z)
	return tuples.tuple(x, y, z, 0)
end

function tuples.add(a, b)
	return tuples.tuple(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w )
end

function tuples.subtract(a, b)
	return tuples.tuple(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w )
end

function tuples.negate(a)
	return tuples.tuple(- a.x, -a.y, -a.z, -a.w)
end

function tuples.multiply(a, num)
	return tuples.tuple(a.x * num, a.y * num, a.z * num, a.w * num)
end

function tuples.divide(a, num)
	return tuples.tuple(a.x / num, a.y / num, a.z / num, a.w / num)
end

function tuples.magnitude(t)
  if not t.w == 1 then
    return 0
  end

	return sqrt(t.x^2 + t.y^2 + t.z^2 + t.w^2)
end

return tuples
