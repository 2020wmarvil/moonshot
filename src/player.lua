Player = Object:extend()

function Player:new(x, y, image)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(image)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.speedX = 100
  self.speedY = 100
end

function Player:update(dt)
end

function Player:draw()  
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
end