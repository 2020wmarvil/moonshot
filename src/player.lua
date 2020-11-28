Player = Object:extend()

function Player:new(x, y)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage("assets/player.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.speedX = 100
  self.speedY = 100
end

function Player:update(dt)
end

function Player:draw()  
  love.graphics.draw(self.image, self.x, self.y, 0, 4, 4, math.floor(self.width / 2), math.floor(self.height / 2))
end