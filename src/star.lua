Star = Object:extend()

star_speed = 30

function Star:new(image)
  self.x = love.math.random(0, SCREEN_WIDTH)
  self.y = -50
  self.angle = love.math.random(1, 360)
  self.image = image
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.destroyable = false
end

function Star:update(dt)
  self.y = self.y + planet_speed * dt
  
  if self.y > SCREEN_HEIGHT + self.height then self.destroyable = true end
end

function Star:draw()
  love.graphics.setColor(1, 1, 1, 0.75)
  love.graphics.draw(self.image, self.x, self.y, self.angle * math.pi / 180, 1, 1, self.width / 2, self.height / 2)  
  love.graphics.setColor(1, 1, 1, 1)
end

function spawnStar()
  return Star(love.graphics.newImage("assets/star.png"))
end
