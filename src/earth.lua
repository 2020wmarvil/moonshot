Earth = Object:extend()

earth_speed = 300

function Earth:new()  
  self.image = love.graphics.newImage("assets/earth.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.x = self.width / 2
  self.y = SCREEN_HEIGHT - self.height / 2
end

function Earth:update(dt)
  self.y = self.y + earth_speed * dt
end

function Earth:draw()  
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
end
