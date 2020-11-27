Player = Object:extend()

function Player:new(x, y, image)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage("assets/sheep.png")
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

function collision(r1, r2)
  return r1.x < r2.x + r2.width 
    and r1.x + r1.width > r2.x 
    and r1.y < r2.y + r2.height 
    and r1.y + r1.height > r2.y
end