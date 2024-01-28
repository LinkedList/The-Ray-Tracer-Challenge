local math = require("math")
local abs = math.abs

local assertions = {}

local EPSILON = 0.00001

function eq_delta(a, b)
	if abs(a - b) < EPSILON then
		return true
	else
		return false
	end
end


function assertions.num_eq(state, arguments)
	if #arguments ~= 2 then
		return false
	end

	if type(arguments[1]) ~= 'number' then
		return false 
	end

	if type(arguments[2]) ~= 'number' then
		return false 
	end

	local a = arguments[1] 
	local b = arguments[2] 
	return eq_delta(a, b)
end

function assertions.tuple_eq(state, arguments)
	if #arguments ~= 2 then
		return false
	end

	if type(arguments[1]) ~= 'table' then
		return false 
	end

	if type(arguments[2]) ~= 'table' then
		return false 
	end

	local a = arguments[1] 
	local b = arguments[2] 

	if not eq_delta(a.x, b.x) then
		return false
	end

	if not eq_delta(a.y, b.y) then
		return false
	end

	if not eq_delta(a.z, b.z) then
		return false
	end

	if not eq_delta(a.w, b.w) then
		return false
	end

	return true
end

return assertions
