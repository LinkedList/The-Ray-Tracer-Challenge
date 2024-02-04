local tuples = require './tuples'
local inspect = require 'inspect'
local floor = require('math').floor

local vector = tuples.vector
local point = tuples.point

local normalize = tuples.normalize
local add = tuples.add
local multiply = tuples.multiply

local canvas_module = require './canvas'
local canvas = canvas_module.canvas
local getWidth = canvas_module.getWidth
local getHeight = canvas_module.getHeight
local write_pixel = canvas_module.write_pixel
local pixel_at = canvas_module.pixel_at
local canvas_to_ppm = canvas_module.canvas_to_ppm
local color = require('./colors').color

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


local p = projectile(point(0, 1, 0), multiply(normalize(vector(1, 1.8, 0)), 11.25))
local e = environment(vector(0, -0.1, 0), vector(-0.01, 0, 0))
local c = canvas(900, 550)

local color = color(0, 1, 0)

local tics = 0
local above_y = true
while above_y do
  p = tick(e, p)
  tics = tics + 1
  if p.position.y <= 0 then
    above_y = false
  end

  local x = p.position.x
  local y = 550 - p.position.y

  if x > 0 and x < 900 and y > 0 and y < 550 then
    -- canvas, x, y, color
    write_pixel(c, floor(p.position.x), 550 - floor(p.position.y), color)
  end
end

local ppm = canvas_to_ppm(c)

local file = io.open('image.ppm', 'w')
file:write(ppm)
file:close()
print('We have a ppm')
