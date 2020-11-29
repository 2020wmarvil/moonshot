Planet = Object:extend()

planet_speed = 30

function Planet:new(image)
  self.x = love.math.random(0, SCREEN_WIDTH)
  self.y = -50
  self.image = image
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.destroyable = false
end

function Planet:update(dt)
  self.y = self.y + planet_speed * dt
  
  if self.y > SCREEN_HEIGHT + self.height then self.destroyable = true end
end

function Planet:draw()
  love.graphics.setColor(1, 1, 1, 0.75)
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)  
  love.graphics.setColor(1, 1, 1, 1)
end

function spawnPlanet()
  local random = love.math.random(1, #planet_images)
  local planet = Planet(planet_images[random])
  return planet
end
