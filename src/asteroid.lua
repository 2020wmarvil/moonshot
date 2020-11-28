Asteroid = Object:extend()

function Asteroid:new(image)
  self.x = love.math.random(0, SCREEN_WIDTH)
  self.y = -50
  self.image = image
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.rotation = love.math.random(0, 90)
  self.rotation_rate = love.math.random(1, 5) / 100
  if love.math.random(1, 2) == 2 then self.rotation_rate = self.rotation_rate * -1 end
  self.destroyable = false  
  
  self.bb_off = math.floor(self.width / 7)
  self.bb = {}
  self:updateBB()
end

function Asteroid:update(dt)
  self.y = self.y + 100 * dt
  self:updateBB()
  
  self.rotation = self.rotation + self.rotation_rate * dt
  
  if self.y > SCREEN_HEIGHT + self.height then self.destroyable = true end
end

function Asteroid:draw()  
  love.graphics.draw(self.image, self.x, self.y, math.deg(self.rotation), 1, 1, self.width / 2, self.height / 2)  
  love.graphics.rectangle("line", self.bb.x1, self.bb.y1, self.bb.x2 - self.bb.x1, self.bb.y2 - self.bb.y1)
end

function Asteroid:updateBB()
  self.bb.x1 = self.x - self.width / 2 + self.bb_off
  self.bb.y1 = self.y - self.height / 2 + self.bb_off
  self.bb.x2 = self.x + self.width / 2 - self.bb_off
  self.bb.y2 = self.y + self.height / 2 - self.bb_off
end  

function spawnAsteroid()
  local random = love.math.random(1, #asteroid_images)
  local asteroid = Asteroid(asteroid_images[random])
  return asteroid
end
