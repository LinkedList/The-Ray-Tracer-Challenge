local tuples = require './tuples'
local inspect = require 'inspect'

local vector = tuples.vector
local point = tuples.point

local normalize = tuples.normalize
local add = tuples.add
local multiply = tuples.multiply

function tick(env, proj)
  local position = add(proj.position, proj.velocity)
  local velocity = add(add(proj.velocity, env.gravity), env.wind)

  return projectile(position, velocity)
end

function projectile(pos, vel)
  return {
    -- point
    position = pos, 
    -- vector
    velocity = vel
  }
end

function environment(g, w)
  return {
    -- vector
    gravity = g,
    -- vector
    wind = w
  }
end


local p = projectile(point(0, 1, 0), multiply(normalize(vector(1, 1, 0)), 3))
local e = environment(vector(0, -0.1, 0), vector(-0.01, 0, 0))

local tics = 0
local above_y = true
while above_y do
  p = tick(e, p)
  tics = tics + 1
  if p.position.y <= 0 then
    above_y = false
  end

  print(inspect(p.position.y))
end

print(tics)
