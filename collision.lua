local vector = require "vector"

local getDistance = function(p1, p2)
  return vector.sum(p1, vector.scale(-1, p2))
end

local circle_vs_circle = function(c1, c2)
  local r = c1.r+c2.r
  local dist_v = getDistance(c1.p, c2.p)
  local dist = math.sqrt(vector.mag_sq(dist_v))
  local dist_norm = vector.norm(dist_v)
  local half_overlap = vector.scale((r - dist)/2, dist_norm)
  return {vector.sum(c1.p, half_overlap), vector.sum(c2.p, vector.scale(-1, half_overlap))}
end

return {
  circle_vs_circle = circle_vs_circle
}
