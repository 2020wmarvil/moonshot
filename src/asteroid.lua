Asteroid = Object:extend()

function Asteroid:new(image)
  self.x = love.math.random(0, SCREEN_WIDTH)
  self.y = 0
  self.image = image
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.rotation = love.math.random(0, 90)
  self.rotation_rate = love.math.random(1, 5) / 100
  if love.math.random(1, 2) == 2 then self.rotation_rate = self.rotation_rate * -1 end
  self.destroyable = false
end

function Asteroid:update(dt)
  self.y = self.y + 100 * dt
  self.rotation = self.rotation + self.rotation_rate * dt
  
  if self.y > SCREEN_HEIGHT + self.height then self.destroyable = true end
end

function Asteroid:draw()  
  love.graphics.draw(self.image, self.x, self.y, math.deg(self.rotation), 1, 1, self.width / 2, self.height / 2)
end

function spawnAsteroid()
  local random = love.math.random(1, #asteroid_images)
  local asteroid = Asteroid(asteroid_images[random])
  return asteroid
end
