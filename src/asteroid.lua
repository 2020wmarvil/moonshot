Asteroid = Object:extend()

function Asteroid:new(image)
  self.x = love.math.random(0, SCREEN_WIDTH)
  self.y = 0
  self.image = love.graphics.newImage(image)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.destroyable = false
end

function Asteroid:update(dt)
  self.y = self.y + 100 * dt
  
  if self.y > SCREEN_HEIGHT + self.height then self.destroyable = true end
end

function Asteroid:draw()  
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
end

function spawnAsteroid()
  a = Asteroid("assets/sheep.png")
  return a
end
