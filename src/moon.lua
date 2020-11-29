Moon = Object:extend()

moon_speed = 300

function Moon:new()  
  self.image = love.graphics.newImage("assets/moon.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.x = self.width / 2
  self.y = -self.height
  
  self.bb = {}
  self:updateBB()
end

function Moon:update(dt)
  if self.y < self.height / 2 then
    self.y = self.y + moon_speed * dt
    self:updateBB()
  else player_move_vertical = true end
end

function Moon:draw()  
  love.graphics.draw(self.image, self.x, self.y, math.pi, 1, 1, self.width / 2, self.height / 2)  
  love.graphics.rectangle("line", self.bb.x1, self.bb.y1, self.bb.x2 - self.bb.x1, self.bb.y2 - self.bb.y1)
end

function Moon:updateBB()
  self.bb.x1 = self.x - self.width / 2
  self.bb.y1 = self.y - self.height / 2
  self.bb.x2 = self.x + self.width / 2
  self.bb.y2 = self.y + self.height / 2
end
